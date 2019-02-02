Return-Path: <SRS0=cvZd=QJ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A904C282DA
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 17:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2D520449
	for <linux-pci@archiver.kernel.org>; Sat,  2 Feb 2019 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfBBRrC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 2 Feb 2019 12:47:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfBBRrB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 2 Feb 2019 12:47:01 -0500
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gpzNb-0005Ot-42
        for linux-pci@vger.kernel.org; Sat, 02 Feb 2019 17:46:59 +0000
Received: by mail-pl1-f197.google.com with SMTP id x7so7990435pll.23
        for <linux-pci@vger.kernel.org>; Sat, 02 Feb 2019 09:46:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n2hrbvigZxzMq8UD9489e8IiUlWO+1g62mvzkPk8Cj8=;
        b=VeXMOwrSwp6hE+RY4ehHlB7vvtC8GmTmttb0HBWwad6W+fhCn6HzHnul3C33rh/jSs
         FibSO3bPfI5wmM3HF4BlTwZ0qrOXmNApeyqR/wSK+gRC3ZdTclxNLfVGvPR0t3GoQk1/
         OwdKb9xGYrOSZDtyDnKiwhhzUzvJXLyiDn/h0Xwo4kkp2XWtfA+8oNUhurdoynkigfJP
         T47+lY2X2PH+1cw0uIS7L4MCKk4t6MCY0SMJm+Y9F8IgiVdWw6v7qmDP1DYyNhRKewfF
         fCiEQjZND0IrbDLJcQjcTGVrF90uFmejErvt6jRtqg9OhDpy8c0WTITI+cfeT74e2gHJ
         W0Bg==
X-Gm-Message-State: AHQUAuYFfepFT/HrcLPJEIrmjjuA27A46RFvQa7v9L1ef+Lj1Aygtyjs
        2Tg49cECy2WAaDCnMjRcVYh1LDOJ0nPHWbEUDuQbxrRnbs94smCnadEkbG7/Df4BjjvmxuVXB7t
        AeBweNGx0QaUpOwLLN0qyh6CHG14/KHsRUBCcoA==
X-Received: by 2002:a65:6242:: with SMTP id q2mr6911672pgv.245.1549129617739;
        Sat, 02 Feb 2019 09:46:57 -0800 (PST)
X-Google-Smtp-Source: AHgI3IZjc5O6nnaJ8s26aG+vOXqziqbwxBjy3hZEQOzeCMe5b+ZOikQASG40XwvbySgEYlMMRehS/w==
X-Received: by 2002:a65:6242:: with SMTP id q2mr6911653pgv.245.1549129617422;
        Sat, 02 Feb 2019 09:46:57 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id h15sm16013649pgl.43.2019.02.02.09.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 09:46:56 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] PCI / ACPI: Don't clear pme_poll on device that has
 unreliable ACPI wake
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
Date:   Sun, 3 Feb 2019 01:46:50 +0800
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, jeffrey.t.kirsher@intel.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CFAC1243-982E-4BAC-BAF6-41568C1C1A9E@canonical.com>
References: <20190122064544.27426-1-kai.heng.feng@canonical.com>
 <20190122235134.GE14636@google.com>
 <91E74111-5BB6-4604-A1D7-B537AB42C317@canonical.com>
 <20190124151524.GF14636@google.com>
 <FFC6EC3F-3608-41FC-8B14-815D1747C4B6@canonical.com>
 <20190124200508.GH14636@google.com>
 <C7E9B3C9-7E20-4CEB-8B56-D9A8D2E76DD0@canonical.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

> On Jan 28, 2019, at 3:51 PM, Kai Heng Feng <kai.heng.feng@canonical.com> wrote:
[snipped]

>> If I understand correctly, the bugzilla lspci
>> (https://bugzilla.kernel.org/attachment.cgi?id=280691) was collected
>> at point 8, and it shows PME_Status=1 when it should be 0.
>> 
>> If we write a 1 to PME_Status to clear it, and it remains set, that's
>> obviously a hardware defect, and Intel should document that in an
>> erratum, and a quirk would be the appropriate way to work around it.
>> But I doubt that's what's happening.
> 
> I’ll ask them if they can provide an erratum.

Got confirmed with e1000e folks, I219 (the device in question) doesn’t really support runtime D3.
I also checked the behavior of the device under Windows, and it stays at D0 all the time even when it’s not in use.

So I sent a patch [1] to disable it.

[1] https://lkml.org/lkml/2019/2/2/200

Kai-Heng


