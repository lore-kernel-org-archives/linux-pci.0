Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35100 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964850Ab2JCS2G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Oct 2012 14:28:06 -0400
Received: by bkcjk13 with SMTP id jk13so6315841bkc.19
        for <linux-pci@vger.kernel.org>; Wed, 03 Oct 2012 11:28:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C5551D9AAB213A418B7FD5E4A6F30A07153272A0@ORSMSX106.amr.corp.intel.com>
References: <1349134020-62152-1-git-send-email-ddutile@redhat.com>
	<CAE9FiQUd=sM3XaMKfJjnJq6mkugL7P=wEjdcMHtGjfe4ooRXUQ@mail.gmail.com>
	<506B4D4C.3080101@redhat.com>
	<20121002203951.GA28663@kroah.com>
	<506B575A.4060304@redhat.com>
	<20121003031018.GB13391@kroah.com>
	<506C3B11.9010009@redhat.com>
	<CAE9FiQUH9LUwrX2_5zoaDBe3pBHBXC4rOctpNMwGN2nJM5pMRQ@mail.gmail.com>
	<C5551D9AAB213A418B7FD5E4A6F30A07153272A0@ORSMSX106.amr.corp.intel.com>
Date: Wed, 3 Oct 2012 11:28:04 -0700
Message-ID: <CAE9FiQXzZ_xeAjXgwkhP7iiTnPX-97Jtd=u_-VC7wjeCDWaQAw@mail.gmail.com>
Subject: Re: [RFC] PCI: enable and disable sriov support via sysfs at per
 device level
From: Yinghai Lu <yinghai@kernel.org>
To: "Rose, Gregory V" <gregory.v.rose@intel.com>
Cc: Don Dutile <ddutile@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"yuvalmin@broadcom.com" <yuvalmin@broadcom.com>,
	"bhutchings@solarflare.com" <bhutchings@solarflare.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 3, 2012 at 11:16 AM, Rose, Gregory V
<gregory.v.rose@intel.com> wrote:
>>
>> I resent my patcheset in plain mail instead of attached form.
>>
>> I am thinking we should ixgbe guys to sort out ixgbe change to use
>> set_max_vfs ops.
>
> I'm willing to do that but I'm sort of waiting for things to settle out a bit and see which set of patches everyone settles on before diving into it.

That would be great !

Actually your changes to ixgbe should be critical changes.

others change to drivers/pci/pci-sysfs.c or adding 3 or 1 methods in driver ops
is not that really matter.

Thanks

Yinghai
