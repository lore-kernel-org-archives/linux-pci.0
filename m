Return-Path: <SRS0=gmVn=QH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE805C169C4
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 16:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2D02085B
	for <linux-pci@archiver.kernel.org>; Thu, 31 Jan 2019 16:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbfAaQLV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:11:21 -0500
Received: from doppler.thel33t.co.uk ([185.153.207.61]:48730 "EHLO
        doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfAaQLU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2019 11:11:20 -0500
X-Greylist: delayed 308 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 11:11:20 EST
Received: from doppler.thel33t.co.uk (localhost [127.0.0.1])
        by doppler.thel33t.co.uk (Postfix) with ESMTP id D03972099F;
        Thu, 31 Jan 2019 16:06:10 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 31 Jan 2019 16:06:10 +0000
From:   Leigh Brown <leigh@solinno.co.uk>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        =?UTF-8?Q?Lu=C3=ADs_Mendes?= <luis.p.mendes@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: Out-of-tree mwlwifi driver crashes
In-Reply-To: <20190131164653.2599d6e7@windsurf>
References: <01e409217be1c1cb08ac3bab072fccd3@solinno.co.uk>
 <20190129155913.163f1e98@windsurf>
 <a56827554c95a3bcd8435d72167d35f9@solinno.co.uk>
 <20190129163117.0af2ebb3@windsurf>
 <8eb5b2981e6e60e91a3eacbb88a5ee7b@solinno.co.uk>
 <20190131164653.2599d6e7@windsurf>
Message-ID: <3029c89268680e5abe4f073d8247f74d@solinno.co.uk>
X-Sender: leigh@solinno.co.uk
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On 2019-01-31 15:46, Thomas Petazzoni wrote:
> Hello Leigh,
> 
> On Tue, 29 Jan 2019 15:36:56 +0000
> Leigh Brown <leigh@solinno.co.uk> wrote:
> 
>> Apologies, I use webmail.  I have attached two files with the results
>> from running lspci -vvv -xxx
> 
> Thanks, that was very useful. I believe the issue comes from the fact
> that your PCIe device has prefetchable BARs, while none of the 5 PCIe
> devices I have here has prefetchable BARs. The pci-mvebu driver doesn't
> support such BARs, but the change to the common PCI bridge emulation
> logic made the prefetchable memory base / limit register read-write
> while they were read-only before.
> 
> To verify this hypothesis, could you apply the following patch (on top
> of 4.20), and see if it solves the problem ? Thanks!
> 
> This is probably not the right/correct fix, but it will at least allow
> to verify that the problem is understood correctly.
> 
> Thomas
> 
> diff --git a/drivers/pci/pci-bridge-emul.c 
> b/drivers/pci/pci-bridge-emul.c
> index 129738362d90..f99b80c19809 100644
> --- a/drivers/pci/pci-bridge-emul.c
> +++ b/drivers/pci/pci-bridge-emul.c
> @@ -142,11 +142,7 @@ const static struct pci_bridge_reg_behavior
> pci_regs_behavior[] = {
>         },
> 
>         [PCI_PREF_MEMORY_BASE / 4] = {
> -               /* The high 12-bits of pref mem base/limit are RW */
> -               .rw = GENMASK(31, 20) | GENMASK(15, 4),
> -
> -               /* The low four bits of pref mem base/limit are RO */
> -               .ro = GENMASK(19, 16) | GENMASK(3, 0),
> +               .ro = ~0,
>         },
> 
>         [PCI_PREF_BASE_UPPER32 / 4] = {

Thanks for responding. I had to manually apply the patch, but it 
certainly fixes
the issue.

Regards,

Leigh.
