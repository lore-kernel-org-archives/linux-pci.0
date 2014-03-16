Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:34439 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaCPP5Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 16 Mar 2014 11:57:24 -0400
Received: by mail-qa0-f42.google.com with SMTP id k15so4439878qaq.15
        for <linux-pci@vger.kernel.org>; Sun, 16 Mar 2014 08:57:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGG0vUiZ2CSyu6Eyj6mUTydsesyPSqSP-XDJzOU+vRxmcqjTsw@mail.gmail.com>
References: <CAGG0vUiZ2CSyu6Eyj6mUTydsesyPSqSP-XDJzOU+vRxmcqjTsw@mail.gmail.com>
Date: Sun, 16 Mar 2014 17:57:24 +0200
Message-ID: <CAGG0vUiYkX-twrdEpnB1s0BWUxskR8F9DLsae9LW4Gthtxmjow@mail.gmail.com>
Subject: Re: [bisected] e501 "agp: Support 64-bit APBASE" agp fails without iommu=remap=2
From: =?UTF-8?B?Sm91bmkgTWV0dMOkbMOk?= <jtmettala@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I opened bug report here:

https://bugzilla.kernel.org/show_bug.cgi?id=72201
