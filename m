Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44383 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbaBTOwr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 09:52:47 -0500
Received: by mail-ig0-f177.google.com with SMTP id h3so3456192igd.4
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2014 06:52:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAHH3p5+jfVULw0PSeTF591p=r8OjXnqwrHEyG063Qf6ct-3VAA@mail.gmail.com>
References: <CAHH3p5+jfVULw0PSeTF591p=r8OjXnqwrHEyG063Qf6ct-3VAA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Feb 2014 07:52:26 -0700
Message-ID: <CAErSpo6JonyTjOw2dm64_vr=NnE-3CGGCxLP-r=28Y2VvnBztg@mail.gmail.com>
Subject: Re: Theoretical maximum speed of a pcie card
To: shiv prakash Agarwal <chhotu.shiv@gmail.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 20, 2014 at 4:50 AM, shiv prakash Agarwal
<chhotu.shiv@gmail.com> wrote:
> Hi All,
>
> Is there a way to know what maximum speed a pcie card supports?
> Like a NIC might be Gen1 only but it may not support whole Gen1 speed.

You can look at the PCIe Link Capabilities register with "lspci -vv".
