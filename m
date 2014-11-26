Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:65361 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbaKZO5l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Nov 2014 09:57:41 -0500
Received: by mail-ig0-f170.google.com with SMTP id r2so8645320igi.1
        for <linux-pci@vger.kernel.org>; Wed, 26 Nov 2014 06:57:41 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 26 Nov 2014 20:27:41 +0530
Message-ID: <CAHH3p5L5bX+9PfZCFHAYmyAS9+kg9CpdQWnAy7WZLCNBm+RYSA@mail.gmail.com>
Subject: PCIE card link up w/ or w/o device connected
From: shiv prakash Agarwal <chhotu.shiv@gmail.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi All,

Is anybody aware of any pcie card which gets detected by root port i.e
link is up only when any device is connected to card? For example:
PCIE USB3 card link is up only when a usb3 device is connected to it.

Is it possible at least? Or card link will always be up whether any
device is connected to it or not?
