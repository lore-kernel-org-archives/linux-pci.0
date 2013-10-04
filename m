Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from co9ehsobe003.messaging.microsoft.com ([207.46.163.26]:58237
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753615Ab3JDC3O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Oct 2013 22:29:14 -0400
Received: from mail104-co9 (localhost [127.0.0.1])	by
 mail104-co9-R.bigfish.com (Postfix) with ESMTP id 3BFFB10007F	for
 <linux-pci@vger.kernel.org>; Fri,  4 Oct 2013 02:29:12 +0000 (UTC)
Received: from CO9EHSMHS022.bigfish.com (unknown [10.236.132.237])	by
 mail104-co9.bigfish.com (Postfix) with ESMTP id 6FC8E420086	for
 <linux-pci@vger.kernel.org>; Fri,  4 Oct 2013 02:29:09 +0000 (UTC)
From: Rajat Jain <rajatjain@juniper.net>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Configuring PCI Express switch over I2C, before PCI enumeration
Date: Fri, 4 Oct 2013 02:29:05 +0000
Message-ID: <9ab5aa58e5f34823800ae08e95ecc539@BN1PR05MB123.namprd05.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello list,

I want to configure a PCI Express switch over I2C before the PCI enumeration begins. I believe such configuration over I2C before PCI enumeration can be very helpful in features like configuring non-transparent ports and virtual PCI domains .

My question is if such a framework already exists that allows this? Also, if you can point me to an example platform code where this may have already been done, that shall be really great!

Thanks,

Rajat 


