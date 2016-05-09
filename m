Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:36738 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbcEIW7z (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 May 2016 18:59:55 -0400
Received: by mail-io0-f177.google.com with SMTP id u185so217675806iod.3
        for <linux-pci@vger.kernel.org>; Mon, 09 May 2016 15:59:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH=XD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q@mail.gmail.com>
References: <CAH=XD5_QVjhSezg-AwO0UrEEwraX2ingWmMbJG0iewyhqbT39Q@mail.gmail.com>
Date: Mon, 9 May 2016 15:59:54 -0700
Message-ID: <CAH=XD5-hO4Q3cMa+iRUsh2U2PLwBO57pt_O2OKAwe=PaOCdnqw@mail.gmail.com>
Subject: Fwd: Intel NTB and a switch in between
From: Kallol Biswas <kallol@nucleodyne.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

We have a requirement to setup intel processor NTB.

We understand that NTB-NTB back to back connection works, but
what if we put a transparent bridge (PCIe Switch) in between two NTBs?


Kallol
