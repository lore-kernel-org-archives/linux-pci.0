Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f177.google.com ([209.85.160.177]:51774 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596AbaBTSvd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 13:51:33 -0500
Received: by mail-yk0-f177.google.com with SMTP id q200so2722615ykb.8
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2014 10:51:32 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 20 Feb 2014 18:51:32 +0000
Message-ID: <CAPcvp5FJLcpe8PunwAyjRBvzESqxx1kv4Sqy0Oqc87Gn9AY3Eg@mail.gmail.com>
Subject: Serialization of configuration accesses for mvebu/designware
From: Andrew Murray <amurray@embedded-bits.co.uk>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	jg1.han@samsung.com, Jason Cooper <jason@lakedaemon.net>,
	mohit.kumar@st.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I've noticed that the mvebu and designware both use spinlocks to
serialize access to the configuration space (pci_ops.[read|write]).
However the read/write ops are only ever used from the pci core
(access.c, pci.c) where they are already protected with the pci_lock.

As far as I can tell these extra spinlocks are superfluous, therefore...

Can they be removed?
Can future host bridge drivers assume that calls to the pci_ops are serialized?

I'm happy to provide a patch for the existing drivers if so.

Thanks,

Andrew Murray
