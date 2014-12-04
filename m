Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61162 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbaLDBo1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 3 Dec 2014 20:44:27 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so14427418iec.25
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2014 17:44:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	<CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
Date: Wed, 3 Dec 2014 17:44:26 -0800
Message-ID: <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	zermond@gmail.com, David Airlie <airlied@linux.ie>,
	saifi.khan@datasynergy.org, Alex Deucher <alexdeucher@gmail.com>,
	kordikmarek@gmail.com, Guo Chao <yan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 3, 2014 at 4:51 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> I think another way to fix the bug 74151 problem would have been to
> put the ROMs in the non-prefetchable window and the 64-bit BARs in the
> 64-bit prefetchable window.

I thought we did that way already.
