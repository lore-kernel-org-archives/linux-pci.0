Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f65.google.com ([209.85.219.65]:54307 "EHLO
	mail-oa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326AbaB0JN4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 04:13:56 -0500
Received: by mail-oa0-f65.google.com with SMTP id n16so712938oag.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2014 01:13:55 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 27 Feb 2014 14:43:55 +0530
Message-ID: <CAHH3p5+G7o3ugf9GkEO3+OD=n2XnBOLbAUDMjr-7EKUrv4-rMA@mail.gmail.com>
Subject: PCIE: Program pcie device private registers
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

One query:

We can program config space registers of a pcie device using setpci
but how can we program private registers of a pcie device?

Can it be done through PCIE interface or something else?
