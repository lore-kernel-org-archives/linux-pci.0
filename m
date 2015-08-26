Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35295 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794AbbHZERV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Aug 2015 00:17:21 -0400
Date: Wed, 26 Aug 2015 06:17:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Tony Luck <tony.luck@gmail.com>,
	Daniel J Blueman <daniel@numascale.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Steffen Persvold <sp@numascale.com>
Subject: Re: [PATCH v4 4/4] Use 2GB memory block size on large-memory x86-64
 systems
Message-ID: <20150826041716.GA14102@gmail.com>
References: <CAE9FiQXWXPexLM8xma8Cb9R9hpR2+tOwzGtmJxzH5uuyPraDpQ@mail.gmail.com>
 <20150821202707.GA920@agluck-desk.sc.intel.com>
 <CAE9FiQU-=oAzi_benuEm=x_Y_LUp48uND6cGnx9osbYyPWySdw@mail.gmail.com>
 <CA+8MBbL4nqTxi14Lz92PRFZeobHBLimSfcTH=9HaZBcEUpLVOg@mail.gmail.com>
 <CAE9FiQVJozeJ9R9GgMEVPfJaSJL+J+M3ULu2VXPjrdDqnYGwvw@mail.gmail.com>
 <CA+8MBb+yJ9ywFnmfCAEPF0ZBQfH1R9b8hzmwVpM8+rsyJkEW5Q@mail.gmail.com>
 <CAE9FiQUDb=uNKV9Bj34v3vvMT04MiuoRHqTq6=KTMd+DVrMVNg@mail.gmail.com>
 <CA+8MBbK6wu+7-M+fP8_GMmhUDSMZ4akOVRkW8xaP8x0pqJN0bQ@mail.gmail.com>
 <CAE9FiQUAAQZ4RF9rTxthBCJAJyDkw1g3dckfeJ870gqK9Dzg9A@mail.gmail.com>
 <CAE9FiQXH0SxTCaw-J=nEhYtbuZfBDU3R+v_XRZYF6ymeXnPsgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQXH0SxTCaw-J=nEhYtbuZfBDU3R+v_XRZYF6ymeXnPsgg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


* Yinghai Lu <yinghai@kernel.org> wrote:

> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -390,8 +390,14 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, int nid)
>  	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
>  	sect_end_pfn += PAGES_PER_SECTION - 1;
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
> -		int page_nid;
> +		int page_nid, scn_nr;
>  
> +		scn_nr = pfn_to_section_nr(pfn);
> +		if (!present_section_nr(scn_nr)) {
> +			pfn = round_down(pfn + PAGES_PER_SECTION,
> +					 PAGES_PER_SECTION) - 1;
> +			continue;
> +		}
>  		page_nid = get_nid_for_pfn(pfn);
>  		if (page_nid < 0)
>  			continue;
> @@ -426,10 +432,18 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  		return -ENOMEM;
>  	nodes_clear(*unlinked_nodes);
>  
> -	sect_start_pfn = section_nr_to_pfn(phys_index);
> -	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
> +	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
> +	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
> +	sect_end_pfn += PAGES_PER_SECTION - 1;
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
> -		int nid;
> +		int nid, scn_nr;
> +
> +		scn_nr = pfn_to_section_nr(pfn);
> +		if (!present_section_nr(scn_nr)) {
> +			pfn = round_down(pfn + PAGES_PER_SECTION,
> +					 PAGES_PER_SECTION) - 1;
> +			continue;
> +		}

NAK due to lack of cleanliness: the two loops look almost identical - this sure 
can be factored out...

Thanks,

	Ingo
