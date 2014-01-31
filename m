Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:56644 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771AbaAaFRC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jan 2014 00:17:02 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so4572159obc.18
        for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2014 21:17:01 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 31 Jan 2014 10:47:00 +0530
Message-ID: <CAHH3p5K+cvnCEsmdU8G6nLSxq0geiORhye+bwKbrbvdkRO3vfQ@mail.gmail.com>
Subject: PCIe memory map API
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Is PCI-E memory space in BARs always mapped as non-normal
non-cacheable by ioremap api by device drivers?
