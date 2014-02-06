Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:58899 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801AbaBFMW7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Feb 2014 07:22:59 -0500
Received: by mail-ob0-f170.google.com with SMTP id va2so2099831obc.1
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2014 04:22:58 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 6 Feb 2014 17:52:58 +0530
Message-ID: <CAHH3p5+zPk6Me6TjKAhL2RWP_osVvEsjh--4JR2i08te9A31qg@mail.gmail.com>
Subject: PCIE bandwidth utilization
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Below queries:

1. Is there a way to find current PCIE bandwidth utilization? i.e How
much of supported bandwidth is being used?
2. Can it happen that a device runs at lower speed that what is
practically possible? i.e suppose a GPU can go upto 100 MBps, but it
needs to run at 50 MBps only?
