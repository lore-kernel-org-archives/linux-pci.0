Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:33723 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbcEIWZx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2016 18:25:53 -0400
Received: by mail-lf0-f47.google.com with SMTP id y84so216749512lfc.0
        for <linux-pci@vger.kernel.org>; Mon, 09 May 2016 15:25:52 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 9 May 2016 15:25:50 -0700
Message-ID: <CAH=XD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q@mail.gmail.com>
Subject: Intel NTB and a switch in between
From: Kallol Biswas <kallol@nucleodyne.com>
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have a requirement to setup intel processor NTB.

We understand that NTB-NTB back to back connection works, but
what if we put a transparent bridge (PCIe Switch) in between two NTBs?


Kallol
