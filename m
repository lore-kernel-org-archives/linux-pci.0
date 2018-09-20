Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E1CECE566
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAE72086E
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 16:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="KCIFD/Kz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAE72086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=networkplumber.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbeITWel (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:34:41 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41128 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbeITWel (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Sep 2018 18:34:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id b12-v6so4616570plr.8
        for <linux-pci@vger.kernel.org>; Thu, 20 Sep 2018 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pt1QIYIfzvX0yPz7k9wxK13xZAanSdHNLYoIwWlc0Tk=;
        b=KCIFD/KzVegL+9eOWuBjN1K7SuKJuhlIxnVnxhJGDSPJDyc2wJnN3GEnKnO09m/2s/
         VbUNB4mHQTQ5GXcoTqXB6S9Sgvybd+atAMokBxT9EL0C2WnrT0Dl2kfeKSqmbleoFJpm
         kT0ZXHy5psZIaNLKStW3kJlbbL0XcPpMqc2bX3+AYKu6yKYN1ghFnpoYIPHv2m3+TUjM
         XFhW2dFeamBIMWM8NuJUapdJB/cC5o9T3LTrfku1kgjX99j3kUl4OcfwKRDjHbp01dho
         cXFmKHxWrUGW/d0Dyh6f9TyNIuvDEi6QFn3WyJGFklU61Y6sEJ+UnZ26dhNgCt8o45lb
         N9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pt1QIYIfzvX0yPz7k9wxK13xZAanSdHNLYoIwWlc0Tk=;
        b=NQa8uVR+0xVMQ2Mu/8+pMqFITJDVVpWkllUwnofSnuU0KVK2PL55wNvAMPL0PI1897
         XdeMcpg6ES0a3S7cj97huJgKz0J6NDitjoExf/6l5ofbdLbw7iCTbeq7psqkeXtXn3Nh
         ThUlcDOXcCrbLKpa5KGh1e37jXstw86BTMMXzdMT8x2JSGZJEJ/Jj1zB6C1I7GaPV2CE
         xlTWOq51wwU+o8+kRe9GFIZecGtGaJ9ARQpPqLpSruGzuls/2ADtRmXDKCv0JL2s2B+c
         0QAhkdGHOcIVKMz0xFFoCmhiDHOxuPbrq4U4GISsTcGLMUkPWLvVHckXB21B1zIC2siV
         mU4Q==
X-Gm-Message-State: APzg51B2suFsxcG+n3Z3cr1AcxIXaauS/gdZ1qDK++3C/6boDENtlVkW
        k70fjK8PKXD/qB8jKGls7pg9yQ==
X-Google-Smtp-Source: ANB0VdZoUX9XExCaAoF9hIlug6q/n0jvZtlWb/KmFZhoPNuXhvOmyOURES7OiSbJkEAk/1F8/8moEg==
X-Received: by 2002:a17:902:b189:: with SMTP id s9-v6mr40136592plr.188.1537462218059;
        Thu, 20 Sep 2018 09:50:18 -0700 (PDT)
Received: from xeon-e3 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id r17-v6sm39902885pff.50.2018.09.20.09.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 09:50:17 -0700 (PDT)
Date:   Thu, 20 Sep 2018 09:50:11 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        devel@linuxdriverproject.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/2] hv_netvsc: associate VF and PV device by serial
 number
Message-ID: <20180920095011.26406404@xeon-e3>
In-Reply-To: <20180920141820.GD838@e107981-ln.cambridge.arm.com>
References: <20180914195457.20433-1-sthemmin@microsoft.com>
        <20180920141820.GD838@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 20 Sep 2018 15:18:20 +0100
Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:

> On Fri, Sep 14, 2018 at 12:54:55PM -0700, Stephen Hemminger wrote:
> > The Hyper-V implementation of PCI controller has concept of 32 bit serial number
> > (not to be confused with PCI-E serial number).  This value is sent in the protocol
> > from the host to indicate SR-IOV VF device is attached to a synthetic NIC.
> > 
> > Using the serial number (instead of MAC address) to associate the two devices
> > avoids lots of potential problems when there are duplicate MAC addresses from
> > tunnels or layered devices.
> > 
> > The patch set is broken into two parts, one is for the PCI controller
> > and the other is for the netvsc device. Normally, these go through different
> > trees but sending them together here for better review. The PCI changes
> > were submitted previously, but the main review comment was "why do you
> > need this?". This is why.  
> 
> The question was more whether we should convert this serial number into
> a PCI slot number (that has user space visibility and that is what you are
> after) to improve the current matching, I do not question why you need
> it, just for the records.

The name slot is way overloaded in this context.
There is 
	windows slot number which comes from Hyperv
	pci address slot which pci-hyperv sets from windows slot
	pci slot api value which for normal devices comes from ACPI
		this patch gets it from serial number


The netvsc driver needed to be able to find a PCI device based on the serial
number. The serial number was not visible in any current PCI-hyperv controller
values.  The windows slot (wslot) is not the same the serial number.
