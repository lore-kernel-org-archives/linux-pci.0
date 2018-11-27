Return-Path: <SRS0=/WWX=OG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CB6C43441
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9368621104
	for <linux-pci@archiver.kernel.org>; Tue, 27 Nov 2018 15:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUQmMh/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9368621104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbeK1CcP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:32:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbeK1CcP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Nov 2018 21:32:15 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D0020817;
        Tue, 27 Nov 2018 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543332838;
        bh=BYOy+4knfpODYIdWjSTvvSHRhY0PnDameul8lIism8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUQmMh/g1400+U65+Wm0vcFYSlV0UXbGwtZIq+h7AjBWOUoFct2AKErS8CfEJ1NoU
         L1y88QbAogInSCi+h6uLZPdhiJzrZbaY9OnWIsLE02tv+D7DXezaS4lVGOyTdeAsUM
         ncm0tNwWrYbUnDkSNTPHNmjDYKYtTH2TaH+4TLJE=
Date:   Tue, 27 Nov 2018 09:33:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Bhushan <bharat.bhushan@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Chris Blake <chrisrblake93@gmail.com>
Subject: Re: [PATCH] PCI: Mark NXP LS1088 to avoid bus reset bus
Message-ID: <20181127153356.GA112381@google.com>
References: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127083454.26560-1-Bharat.Bhushan@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc David, Jan, Alex, Maik, Chris]

On Tue, Nov 27, 2018 at 08:46:33AM +0000, Bharat Bhushan wrote:
> NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
> bus reset with e1000e. Link state of device does not comes UP and so
> config space never accessible again.

Previous similar commits:

  822155100e58 ("PCI: Mark Cavium CN8xxx to avoid bus reset")
  8e2e03179923 ("PCI: Mark Atheros AR9580 to avoid bus reset")
  9ac0108c2bac ("PCI: Mark Atheros AR9485 and QCA9882 to avoid bus reset")
  c3e59ee4e766 ("PCI: Mark Atheros AR93xx to avoid bus reset")

1) Please make your subject match (remove the spurious "bus" at the
end)

2) This should probably be marked for stable (v3.14 and later, since
the quirk itself appeared in v3.19 and marked for v3.14 and later
stable kernels).  Maybe even mark it as "Fixes: c3e59ee4e766..." to
connect it.

3) The 1957:80c0 PCI ID doesn't appear in https://pci-ids.ucw.cz/; can
you add it?

4) Is there a hardware erratum for this?  If so, please include the
URL here.

5) Can you reproduce the problem using the same endpoint (e1000e) on a
different system with a different bridge?

6) Have you looked at this with a PCIe analyzer?  It would be very
interesting to compare the boot-time or system reboot path with the
individual bus reset path you're fixing.

Since there are several similar reports and they sometimes involve the
same devices (both your patch and 822155100e58 mention e1000e), I'm a
little suspicious that we're doing something wrong in the bus reset
path.

I think bus reset uses Secondary Bus Reset in the Bridge Control
register.  That's a generic mechanism that I would expect to be pretty
well-tested.  I suspect the BIOS probably uses it in the reboot path,
and the device probably works after that.

So I wonder if the Linux delay isn't quite long enough, or our first
access to the device isn't quite right, e.g., maybe there's some issue
with the bus/device number capture (PCIe r4.0, sec 2.2.6.2).

> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  drivers/pci/quirks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4700d24e5d55..b9ae4e9f101a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3391,6 +3391,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>  
> +/*
> + * NXP (Freescale Vendor ID) LS1088 chips do not behave correctly after
> + * bus reset. Link state of device does not comes UP and so config space
> + * never accessible again.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x80c0, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> -- 
> 2.19.1
> 
