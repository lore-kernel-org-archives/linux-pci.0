Return-Path: <SRS0=vmzI=QL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53A4C282C4
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 773C120823
	for <linux-pci@archiver.kernel.org>; Mon,  4 Feb 2019 17:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549300868;
	bh=kzqRnyuBxEMwny9S1KAaOc8Hk/9Dq+BuvG5G5dG2CC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LCbVowDILzs90yppPCSL+BHMRqAjpQJQfOtxSzGDU3CvxGQMmFOUd70v7iHgejB+7
	 loTSG6lD2/9rEaFicVgRjMQO/nzHlTNn9GEzbyEeTTqVTI1tQMOd7rwEuv7yUSpbm5
	 4RK1AHTkQY9dHC2Vbwk+S/flP7TuWhNVhvLlXPok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfBDRU7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfBDRU7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Feb 2019 12:20:59 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7045A20823;
        Mon,  4 Feb 2019 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549300858;
        bh=kzqRnyuBxEMwny9S1KAaOc8Hk/9Dq+BuvG5G5dG2CC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyAG+Y8xBlZ0NNo7Nm1k1egfzaqVPrv5uZ1tKQSYwp1Vqm5YByXPeq1EJ0VXBPPoW
         1QgA9b8SsPE6v+Ss1D5s7kBZDfRimyNkxG9HfBDPmjDDaWVyFuqM2RUOgSbt/VEx0z
         011RzASKZaruoPj1imfGUBsZAU6Hjb1o8klOeql0=
Date:   Mon, 4 Feb 2019 11:20:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
Message-ID: <20190204172057.GB9160@google.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
 <20190124200508.GH14636@google.com>
 <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
 <CFAC1243-982E-4BAC-BAF6-41568C1C1A9E@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CFAC1243-982E-4BAC-BAF6-41568C1C1A9E@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 03, 2019 at 01:46:50AM +0800, Kai Heng Feng wrote:
> > On Jan 28, 2019, at 3:51 PM, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> >> If I understand correctly, the bugzilla lspci
> >> (https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
> >> at point 8, and it shows PME_Status=1 when it should be 0.
> >> 
> >> If we write a 1 to PME_Status to clear it, and it remains set, that's
> >> obviously a hardware defect, and Intel should document that in an
> >> erratum, and a quirk would be the appropriate way to work around it.
> >> But I doubt that's what's happening.
> > 
> > I’ll ask them if they can provide an erratum.
> 
> Got confirmed with e1000e folks, I219 (the device in question) doesn’t
> really support runtime D3.

Did you get a reference, e.g., an intel.com URL for that?  Intel
usually publishes errata for hardware defects, which is nice because
it means every customer doesn't have to experimentally rediscover
them.

> I also checked the behavior of the device under Windows, and it
> stays at D0 all the time even when it’s not in use.

I think there are two possible explanations for this:

  1) This device requires a Windows or a driver update with a
  device-specific quirk similar to what you're proposing for Linux.

  2) Windows correctly detects that this device doesn't support D3,
  and Linux has a bug and does not detect that.

Obviously nobody wants to require OS or driver updates just for minor
device changes, and the PCI and ACPI specs are designed to allow
generic, non device-specific code to detect D3 support, so the first
case should be a result of a hardware defect.

> So I sent a patch [1] to disable it.
> 
> [1] https://lkml.org/lkml/2019/2/2/200

OK.  Since that's in drivers/net/..., I have no objection and the
e1000e maintainers would deal with that.

Bjorn
