Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33411 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbcAaHPf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 31 Jan 2016 02:15:35 -0500
Received: by mail-io0-f173.google.com with SMTP id f81so127309342iof.0
        for <linux-pci@vger.kernel.org>; Sat, 30 Jan 2016 23:15:35 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 31 Jan 2016 02:15:34 -0500
Message-ID: <CAJ2oMhL-oL68ZOLsFEn3uGE=O9sMjcwPDH6oznLhG15xnzSQtQ@mail.gmail.com>
Subject: Q: Relation between lanes to devices and to BARs
From: Ran Shalit <ranshalit@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I am new to pci express drivers, and would please like to ask a question.
We develop a linux driver for a PCIe device board with 4 lanes.
1. Is it expected that this will be recognized as a single device or
multiple device ?
2. Is it that each lane rales to a different BAR or there is no
connection between these two ?

Thank you,
Ran
