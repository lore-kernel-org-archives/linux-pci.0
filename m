Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:59989 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755415AbaC0LCt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 07:02:49 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so3987701obc.21
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2014 04:02:48 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 27 Mar 2014 16:32:48 +0530
Message-ID: <CAHH3p5Km5_hKvNizysUp=LsbBw2jEJAZ_NdwPDCSi1PBrAdRyw@mail.gmail.com>
Subject: Read/Write BARs of device directly
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I have a kernel space testcode which does below after all enumeration
and driver loading is done:

1. read BARx address of endpoint from its config space
2. ioremap this physical address to get virtual address
3. read this virtual address using readl/readw api

Query is:

1. Does read in point 3 above happens through PCIE interface?
2. Is it upstream or downstream traffic?
3. Could we do corresponding write also?
