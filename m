Return-Path: <SRS0=33lb=RY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57BFC43381
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 23:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702FB218D3
	for <linux-pci@archiver.kernel.org>; Thu, 21 Mar 2019 23:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfCUXIR (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:08:17 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41179 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfCUXIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Mar 2019 19:08:16 -0400
Received: by mail-io1-f72.google.com with SMTP id e126so148ioa.8
        for <linux-pci@vger.kernel.org>; Thu, 21 Mar 2019 16:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=hBKD7f2HkIDdNnRVBYci/PpLhJKAtA+yAwwLcN1m4mU=;
        b=Q5mrg7j9UIQCse8Y8HgROGS1+wVM8YMI+r/nwEchOmF3agtH6okNt/+sZ3OOqV1kMy
         X47HmDpv5ipWKwhgW3qFdQcuSkgndia0E0FfwnStblSDbwxnPvDzigg/3NpzowmfivxV
         EA0YTfUZPU6xZnsPsmeEnFZQam6QJqrTB9FUkmsF0hIAe1E6M8WZMl3yEYhed7AWTkbC
         mbgrKvWVijqZbBBOV2rjNCosVZTX9WEtpzrihDRQdx0e4ozW3v5P5+Wn+ukR/7Wn9MZZ
         3hkC0K0wawLw+bYImONhwMqQxugg9aB4RZsaiwFfQM5vp2eollK7UWFCukuAg3Xqe1s8
         H4OQ==
X-Gm-Message-State: APjAAAVwiBE+dReQkXGVuaCZpJrw4TXVC7D/JzGzpcwTmo4okm3Xmloy
        jZ5vIpmOrxaoHSyzVFefiTh+pA5ONv/b9jVHmSNevUF19yl0
X-Google-Smtp-Source: APXvYqxJVB4oaGrUcbyaKassz5VuxuxIcnvlCS6n0Qq5jVohJVdVmypBUNb8WGpIB5LNW2FVjTG2QloPzGNThDZ/EV/w1uowR6pn
MIME-Version: 1.0
X-Received: by 2002:a24:5a8d:: with SMTP id v135mr978231ita.87.1553209680596;
 Thu, 21 Mar 2019 16:08:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:08:00 -0700
In-Reply-To: <000000000000c4ba820579737025@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000461a4c0584a2cfd2@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in _decode_session6 (2)
From:   syzbot <syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com>
To:     bhelgaas@google.com, daniel@iogearbox.net, davem@davemloft.net,
        devel@acpica.org, herbert@gondor.apana.org.au,
        kuznet@ms2.inr.ac.ru, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lv.zheng@intel.com, mkl@pengutronix.de,
        netdev@vger.kernel.org, rafael.j.wysocki@intel.com,
        rjw@rjwysocki.net, robert.moore@intel.com, socketcan@hartkopp.net,
        steffen.klassert@secunet.com, syzkaller-bugs@googlegroups.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

syzbot has bisected this bug to:

commit 64fd1c7040880292710e6592ddc88d0d73cfb6fb
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Jun 12 20:48:41 2017 +0000

     ACPI / PM: Run wakeup notify handlers synchronously

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1555b12b200000
start commit:   64fd1c70 ACPI / PM: Run wakeup notify handlers synchronously
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1755b12b200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1355b12b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93932074d01b4a5
dashboard link: https://syzkaller.appspot.com/bug?extid=240f9766d6be3d69431e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f35e4d400000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1280edbd400000

Reported-by: syzbot+240f9766d6be3d69431e@syzkaller.appspotmail.com
Fixes: 64fd1c704088 ("ACPI / PM: Run wakeup notify handlers synchronously")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
