Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:54210 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932170AbaAaRss (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 12:48:48 -0500
Received: by mail-ob0-f169.google.com with SMTP id wo20so5387413obc.28
        for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2014 09:48:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5K+cvnCEsmdU8G6nLSxq0geiORhye+bwKbrbvdkRO3vfQ@mail.gmail.com>
References: <CAHH3p5K+cvnCEsmdU8G6nLSxq0geiORhye+bwKbrbvdkRO3vfQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 31 Jan 2014 10:48:28 -0700
Message-ID: <CAErSpo6uAs0v-KJ6jvraPfuUafJnFNKHhGaofPRp32Amm94jog@mail.gmail.com>
Subject: Re: PCIe memory map API
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 30, 2014 at 10:17 PM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Is PCI-E memory space in BARs always mapped as non-normal
> non-cacheable by ioremap api by device drivers?

PCI memory BARs are not mapped at all until a driver requests it by
calling ioremap() or a similar interface.  ioremap() gives you a
non-cacheable mapping.

Bjorn
