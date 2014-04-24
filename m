Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:38427 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbaDXHp6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Apr 2014 03:45:58 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so2241230obc.20
        for <linux-pci@vger.kernel.org>; Thu, 24 Apr 2014 00:45:58 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 24 Apr 2014 13:15:58 +0530
Message-ID: <CAHH3p5Jib+ypEM0kUtRTn-qpfYCqw60fRKqjsNxbQpNTo+Zouw@mail.gmail.com>
Subject: PCIE support as loadable module
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andrew Murray <amurray@embedded-bits.co.uk>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Can we support PCIE driver as loadable module instead of including it in kernel?
