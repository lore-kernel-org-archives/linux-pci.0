Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC72C4361B
	for <linux-pci@archiver.kernel.org>; Wed, 16 Dec 2020 19:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D76221FA
	for <linux-pci@archiver.kernel.org>; Wed, 16 Dec 2020 19:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbgLPTOG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:14:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbgLPTOF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Dec 2020 14:14:05 -0500
Date:   Wed, 16 Dec 2020 12:20:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608142823;
        bh=G5QC+s8/mxid++XQG3CrjKnyrmLeds62x+7OAGC/H/g=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=dDTPlDNZqteJl/dqyYpOI4vcRI0MmAF8mBCVJSpBvjFuSrak1u6cJwSAK1jt0QnMw
         NtB75OgBPP6qHN7LfrCzAaXXV4m3WufvdEqV1gP2Hj5tL5qjuq6oMxI3kvCRCOGTTA
         nmoTgRCFQgrBMfES8LPXGRvtImXMZ5nUyZUzylb5VNPkuLPzxlPzpUn51HuQAXI9T0
         1OK/5ve86Eo5C/lg9xxiVQ6id9hJS6Nh2nUofRPEeuEZncG/wP6fZ6MaBLMf3qFz2I
         5ehUzMHbZ29aVGmM6MaiLwnxcIV3LgUWI1JxT7J4fGmhYSoquRiDFVIXt0VYhS1sDi
         pJMjpe/oSR3yA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
Message-ID: <20201216182022.GA356517@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87361bf6-0fef-3641-1dcb-21c56a2cf0b0@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 16, 2020 at 06:56:11PM +0100, Marek Vasut wrote:
> On 12/14/20 9:38 PM, Bjorn Helgaas wrote:
> > On Tue, Dec 08, 2020 at 07:05:09PM +0100, Marek Vasut wrote:
> > > On 12/8/20 5:40 PM, Bjorn Helgaas wrote:
> > 
> > > > Does this problem occur in both these cases?
> > > > 
> > > >     1) When ASPM enters L1, and
> > > > 
> > > >     2) When software writes PCI_PM_CTRL to put the device in D3hot?
> > > > 
> > > > IIUC both cases require the link to go to L1.  I guess the same
> > > > software workaround applies to both cases?
> > > 
> > > Yes
> > 
> > If ASPM puts the Link in L1 and the device needs to DMA, how does the
> > Link get back to L0?
> 
> It cannot, so I would expect the DMA access would fail.

I think that means we cannot enable ASPM L1 at all on this device.  I
don't think devices or drivers are prepared to deal with this sort of
DMA failure.  At least, if there is a mechanism for dealing with it, I
don't know what it is.

Preventing use of ASPM L1 probably means some sort of quirk to
override whatever the controller advertises in its Link Capabilities
register.

The software-controlled PCI-PM model (where software writes to the
PCI_PM_CTRL register) is different, and it may still be possible to
use L1 then.  If software puts the device in D1, D2, or D3hot, the
device cannot initiate DMA.  If it needs to return to D0, it would
have to use the PME mechanism, so there is an opportunity for the
software workaround.

> > Do we use the same data abort hook?  If getting
> > back to L0 requires help from software, it seems like that would
> > invalidate the L1 exit latency advertised by the devices.  Wouldn't
> > that mean we couldn't safely enable L1 at all unless the endpoint
> > could tolerate unlimited exit latency?
> 
> Possibly, there could be limitations to the L1 support in some corner cases.
> Does that mean the L1 support should be disabled completely ?

The L1 exit latency only applies to the ASPM case.  It sounds like we
will have to disable L1 for ASPM.  But the exit latency doesn't apply
to the PCI-PM model where software will explicitly return the device
to D0, and the device should not initiate a transaction until it sees
the link back in L0.

Bjorn
