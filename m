Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:34007 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbcAMQVb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2016 11:21:31 -0500
Received: by mail-vk0-f52.google.com with SMTP id a123so234012731vkh.1
        for <linux-pci@vger.kernel.org>; Wed, 13 Jan 2016 08:21:31 -0800 (PST)
MIME-Version: 1.0
From: Justin Waters <justin.waters@timesys.com>
Date: Wed, 13 Jan 2016 11:14:47 -0500
Message-ID: <CAENNV6JHnwNWDi3ACRE+p3fvMzii+di-CRkH-wO4qwEa9nNN7g@mail.gmail.com>
Subject: i.MX6 PCI GPR8 Settings
To: linux-pci@vger.kernel.org
Cc: xobs@kosagi.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I've been working with a custom board based on an i.MX6, and noticed
that the GPR8 settings for the PCIe pins are hard coded to specific
values. We would like to customize these values for our specific
hardware.

While it's certainly possible to simply change the hard coding, it
strikes me that these should most likely be configurable via the
device tree. My initial thinking would be to create a number of
properties that would be defined in a dts file, e.g.
fsl,pci-deemph-gen1 = < 0>, but perhaps there's a better way to handle
this. I'm happy to put something together, but I'd like to know that
I'm on the right track. I'd appreciate any feedback.

Thank you,

-- 
Justin Waters
Director of Engineering
Timesys Corporation
