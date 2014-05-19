Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44791 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbaESPJ7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 May 2014 11:09:59 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4JF9xeg011291
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 10:09:59 -0500
Received: from DLEE70.ent.ti.com (dlee70.ent.ti.com [157.170.170.113])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4JF9xqX022294
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2014 10:09:59 -0500
Received: from [158.218.103.123] (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4JF9wOw013109	for
 <linux-pci@vger.kernel.org>; Mon, 19 May 2014 10:09:58 -0500
Message-ID: <537A1EC6.30800@ti.com>
Date: Mon, 19 May 2014 11:09:58 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: What is the right way to initialize the VendorID info of the RC's
 config space?
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Keystone PCI controller's config space doesn't have the vendorID 
information set and s/w is expected to
read this info from the SoC's register and update. Is adding a quirk for 
this the right thing to do?

Murali


