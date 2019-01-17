Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B50C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA20720855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 14:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh7i1m18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfAQOzz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:55:55 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36305 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfAQOzz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 09:55:55 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so11591163qtn.3
        for <linux-pci@vger.kernel.org>; Thu, 17 Jan 2019 06:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=0mYw9z1n97fgE79A4rUjgU6o+QJvu/WeeMBJyKY8cak=;
        b=Dh7i1m18UDU3yqbSjLLo7R2ZR2zJV33CtOirKu9Ma8DKqNVKBh3CX8qLSBsFlvYsFQ
         4W4rpkz8io3WMOron6Qnfj/88u1v+WOlOS54mVgjBad9UX1HpMydy2vZLb13CdS0TqM6
         ae7eCyLPv30VUPQe7yul7byRTk4veLI20Ugx+759jw8W+yFIBxuLDezLdeT8LsYpEDfr
         HhZdGosQStNeXwysRaUwHi6vdKAypiI2wUEuf4rdtrEbe7eYgDF8wx2UfacVw6c9MP6d
         pgkRjGHLoztkN3Tq4osUQDoiZ+F/zhkX+usyEGr1b89c61eNhEiHSgbKRcUET3BPnePJ
         DiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=0mYw9z1n97fgE79A4rUjgU6o+QJvu/WeeMBJyKY8cak=;
        b=KuVWKur9t0AkNPHOcBIWpI+ly8nKz6zh01snlCldft0EMW/5UIBpU5tP9lr91L4pen
         ypFk1VMa0CfYZroTkfK1nNMVnAIDnQZcnUBZ6X81yYHRweNsHk/LJXWwjTwFquFNfSdn
         BPth12lWXAxujDBTYB6Eje1ECm0D+j29OOQJ847PpV7IRaAmTN5c7YiY5LfyPgXTWHT0
         ywPLzLQgIBKIMxG4WNkKZIIYc5xh0n0kWPoBliAl/CEPKsCU/x9BPa3/JcNT55MVJTF9
         s4nyx4SJNR6Bdszj2GBLS6ZRRzQyj3JL3Z/0a+PRtyC1S4zZj4o/5bDu78jmowOivISL
         Khmw==
X-Gm-Message-State: AJcUukeoP1Njioe7CFfTQJ+OQjhL3z+D7j3vTIVHINeqKJ5PmSZVW0Df
        b9TnmGprjywktzr7OEBnk5jI59COu7ympmFmq1Y=
X-Google-Smtp-Source: ALg8bN4K5S9g70VN4wYcGXp0aG3f5hbnGfgvlUKPQPaUlaVvERwO5t+7Iq+jGEdZIiXBw2Db1GQO1wHPRcZtI1tPVmc=
X-Received: by 2002:ac8:2ccc:: with SMTP id 12mr11612315qtx.277.1547736953649;
 Thu, 17 Jan 2019 06:55:53 -0800 (PST)
MIME-Version: 1.0
References: <bug-202319-193951@https.bugzilla.kernel.org/>
In-Reply-To: <bug-202319-193951@https.bugzilla.kernel.org/>
Reply-To: bjorn@helgaas.com
From:   Bjorn Helgaas <bjorn.helgaas@gmail.com>
Date:   Thu, 17 Jan 2019 08:55:42 -0600
Message-ID: <CABhMZUUX2fMgutB7Xp8Zi+x9xJkEKe2T8Bvr1SfzT9UsPEXruw@mail.gmail.com>
Subject: Fwd: [Bug 202319] New: Wrong outbound region start address
 calculation in Keystone II PCIe driver
To:     monakov.y@gmail.com, Murali Karicheri <m-karicheri2@ti.com>
Cc:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yurii, Murali,

The patch attached to the bugzilla would need to be updated to apply
to the current tree (looks like it was generated in a tree before we
moved things to drivers/pci/controller/dwc/).  It would also need to
be posted to linux-pci@vger.kernel.org with a changelog and
signed-off-by (see
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst)

---------- Forwarded message ---------
From: <bugzilla-daemon@bugzilla.kernel.org>
Date: Thu, Jan 17, 2019 at 6:14 AM
Subject: [Bug 202319] New: Wrong outbound region start address
calculation in Keystone II PCIe driver
To: <bugzilla.pci@gmail.com>


https://bugzilla.kernel.org/show_bug.cgi?id=202319

            Bug ID: 202319
           Summary: Wrong outbound region start address calculation in
                    Keystone II PCIe driver
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.14
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: PCI
          Assignee: drivers_pci@kernel-bugs.osdl.org
          Reporter: monakov.y@gmail.com
        Regression: No

Created attachment 280553
  --> https://bugzilla.kernel.org/attachment.cgi?id=280553&action=edit
Fixes wrong OB_OFFSET_INDEX calculation in Keystone II PCIe driver

In function ks_pcie_setup_rc_app_regs (drivers/pci/dwc/pci-keystone.c:602):

---

/* Using Direct 1:1 mapping of RC <-> PCI memory space */
for (i = 0; i < num_viewport && (start < end); i++) {
        ks_pcie_app_writel(ks_pcie, OB_OFFSET_INDEX(i),
                           lower_32_bits(start) | OB_ENABLEN);
        ks_pcie_app_writel(ks_pcie, OB_OFFSET_HI(i),
                           upper_32_bits(start));
        start += OB_WIN_SIZE;
}

---

Here OB_WIN_SIZE is declared as 8, so region start address is incremented by 8
instead of 8M.

--
You are receiving this mail because:
You are watching the assignee of the bug.
