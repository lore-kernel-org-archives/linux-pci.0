Return-Path: <SRS0=f7a+=NU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF7C43441
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 21:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDE320827
	for <linux-pci@archiver.kernel.org>; Fri,  9 Nov 2018 21:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCtRVODr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDE320827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbeKJHZq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:25:46 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:40131 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbeKJHZq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Nov 2018 02:25:46 -0500
Received: by mail-it1-f169.google.com with SMTP id e11so5504980itl.5
        for <linux-pci@vger.kernel.org>; Fri, 09 Nov 2018 13:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=/VcJ/avfxBXz9O5A8VZwrBbdKMKLcbesuiK1KzRal4g=;
        b=eCtRVODr8ia2dz2wqc2BDsTq4EqbKPWSH6n0Z/nq+Pd7P0Yuvk6RfI+RjKdt7Fzq9j
         +32shh0we1C5somhIv1L0jmObXjtb9iXGEMQBOrWGFvhjABLR4LGFtI1txAS5cSiZy1A
         SJcrElTQw/3GWRqbF/8sjC/P2dOunYSaPCTAIyJ5Q1HeA7ERLV5Nnp1NV9gYdfp8CSMT
         Gwn44hEWoqQbSCsfyFSxh+fxALweF372preUNeUpC1YSKov32/WAxR496pVmTYzq/3u5
         iIxBXrtOCp4fZh4ZsK+sRxFX+HjsPn0hDDPQ7ObWz6G5JL95C4kIiaU5PLehf/iC1vT7
         S8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=/VcJ/avfxBXz9O5A8VZwrBbdKMKLcbesuiK1KzRal4g=;
        b=biOewcnEolKkocxracpYmwBvnOABsRR5krFNt2LmcU8Ah2UwsZYHaw2iOmh+O9SKRO
         L0mylYWL9dGWK45SBK9HhvJBGmSQ8gHBIvASGqA3iqfYiuMThnaVu0KW8RwDRqcOlgwN
         8NR7gC8XB8eUgfuFiqbDl6ffZbVsJyqIwNXdZzBRFn3FSMmH8uIYmSA5mDkTY7K5Utcx
         ueWhM/WR6TE3uN9/A+JKRa/MR4O1RfokWP4cC+w9wwVy4FayidGg3QIRXzB/x2pBULK9
         aVMEWhKrrgvVdfvFz4mg1yvlfPoeRaqtWAOepytKnaWXazt5VOD9q5jjl0apLoTCN2uA
         5RHA==
X-Gm-Message-State: AGRZ1gIHw65WoFLuBSAWPGJa1w/9cnbbSInz4vlCUHA4UznHuUdPJDg/
        0vo2AlPIpKkoGqxMRwdycki3xeTgBr/ujTxxXw1kwndB
X-Google-Smtp-Source: AJdET5e47Ln4tnhKM77dZZC7JbLQ8bzDjj89gMZGr+j9RuFyRpQXy0rdbm3Lhr2ogg4tbECtV1LIGzuWOdBBADw6OPw=
X-Received: by 2002:a24:1a87:: with SMTP id 129-v6mr3936760iti.23.1541799798855;
 Fri, 09 Nov 2018 13:43:18 -0800 (PST)
MIME-Version: 1.0
References: <bug-201647-193951@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201647-193951@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Fri, 9 Nov 2018 15:43:06 -0600
Message-ID: <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
Subject: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get detected
 but bluetooth works
To:     linux-pci@vger.kernel.org
Cc:     Mertarg10@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[Resend because I forgot to send as plain text and linux-pci rejected it.]

The report below shows only one PCI-PCI bridge (00:13.0) but no
devices below it.  I wonder if that's related to whatever's wrong with
this host bridge window:

  acpi PNP0A08:00: host bridge window [mem 0x1000000010000 window]
(ignored, not CPU addressable)
  pci 0000:00:13.0: PCI bridge to [bus 01]

Mertarg10, would you mind attaching the "sudo lspci -vv" output, too?

---------- Forwarded message ---------
From: <bugzilla-daemon@bugzilla.kernel.org>
Date: Fri, Nov 9, 2018 at 4:10 AM
Subject: [Bug 201647] New: Intel Wireless card 3165 does not get
detected but bluetooth works
To: <bugzilla.pci@gmail.com>


https://bugzilla.kernel.org/show_bug.cgi?id=201647

            Bug ID: 201647
           Summary: Intel Wireless card 3165 does not get detected but
                    bluetooth works
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.1
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: Mertarg10@gmail.com
        Regression: No

Created attachment 279385
  --> https://bugzilla.kernel.org/attachment.cgi?id=279385&action=edit
Contains outputs of dmesg and lspci

This bug affects most of the devices with a Celeron N4000 and an Intel wifi
3165 Ac adapter.

When using Linux wifi is not working however, Bluetooth is working fine.
Also, Bluetooth part of this chip is connected via btusb and the wifi part of
this chip is connected via PCIe.

I have contacted the Linux wireless team of Intel, which suggested me to report
this bug as a PCIe bug.

--
You are receiving this mail because:
You are watching the assignee of the bug.
