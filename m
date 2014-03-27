Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:61342 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469AbaC0KyN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 06:54:13 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so4015433oag.26
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2014 03:54:12 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 27 Mar 2014 16:24:12 +0530
Message-ID: <CAHH3p5+aJfJ_vdkpVbOvi8OgDsv-UgbRg+keE-YSUwrF8c93tA@mail.gmail.com>
Subject: Test MSI without device driver
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pratyush Anand <pratyush.anand@st.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Could we test MSI functionality of Root Complex without having Endpoint driver?
If not, could we use some test code just to simulate endpoint driver
for MSI functionality?
