Return-Path: <SRS0=Jg1T=2U=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85500C2D0C3
	for <linux-pci@archiver.kernel.org>; Mon, 30 Dec 2019 23:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C672071E
	for <linux-pci@archiver.kernel.org>; Mon, 30 Dec 2019 23:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577750346;
	bh=aw3uPwg9jYCP2G9VjPAtTKdZZpAsL71kvFq58sx1GGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=AaSDt9RjbJnYLxESy0IB9bwZ6fURg82jl0Mh+J0YXtV4Dgyp4OZuXgeJUVmdhGfRb
	 glV0NH2sv8GHcBNU/bdV3X8JbFjobkvB5/ifIbZHzGxcX3CpmCsbe63YVSFtPBL78x
	 dVctFhkqpvOBpkp9mjOervfJtnSq1QzRXxEd5d+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfL3X7F (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 30 Dec 2019 18:59:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbfL3X7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Dec 2019 18:59:05 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2474120658;
        Mon, 30 Dec 2019 23:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577750344;
        bh=aw3uPwg9jYCP2G9VjPAtTKdZZpAsL71kvFq58sx1GGs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SxxHB05rWlj1c5U6ycBpBN4b8J8QNbpviUlBZljRfwwQv1AFNlc6N42dDbSr6+XxV
         OqvE41sZ87FJ1vwtTLYeZcjRuwmL42Ua82MOLK9baRJ6vuvMX7mqfYPZ6dP3OqDBVg
         TSUNQu0ppC92rvXyH0P0+PoEmDlSQMo/BMMSKbrg=
Date:   Mon, 30 Dec 2019 17:59:02 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com, Austin.Bolen@dell.com
Subject: Re: [PATCH v11 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
Message-ID: <20191230235902.GA226371@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c778a619d164f5202248543dc5eec99c079fb82e.1577400653.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Austin]

On Thu, Dec 26, 2019 at 04:39:11PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> As per PCI firmware specification r3.2 System Firmware Intermediary
> (SFI) _OSC and DPC Updates ECR
> (https://members.pcisig.com/wg/PCI-SIG/document/13563),

What is the state of this ECR?  I see it in the "PCI Express Review
Zone Archive".  I don't know what the usage is of the "Review Zone" vs
the "Review Zone Archive / PCI Express Review Zone Archive".  AFAICS,
it is not listed in any of the "Documents for 60 Day Member Review".

And I think it needs some clarification (for one thing, it needs to
say what the red/blue text means).  I've mentioned some other items to
Austin, but I haven't read it in detail because it seems like it's not
quite baked yet.

E.g., there's language about "it may make sense for an embedded system
OS to own SFI, but it's recommended that general-purpose OSes never
request SFI ownership."  That's useless: Linux is certainly a general
purpose OS, but Linux is also often an embedded OS.  So the ECR
doesn't provide useful guidance about how an OS should decide whether
to request SFI ownership.

Making code changes based on a published spec or ECN is fine,
obviously.  Changes based on an ECR that is well on track to being
accepted, e.g., is in the 60-day review period, are probably OK.  I
don't yet have warm fuzzies about this ECR because I have no idea how
far along it is.

We might be able to justify some of these changes based on other
specs; it just sounds weird to me to say "based on this Engineering
Change Request that might be accepted someday, we must do X".  Anybody
can dream up an ECR that says anything at all, so AFAICT, an ECR is
not at all authoritative.

> sec titled
> "DPC Event Handling Implementation Note", page 10, Error Disconnect
> Recover (EDR) support allows OS to handle error recovery and clearing
> Error Registers even in FF mode. So create exception for FF mode checks
> in pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
> and pci_cleanup_aer_error_status_regs() functions when its being called
> from DPC code path.
