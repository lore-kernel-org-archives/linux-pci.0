Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52858 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753869AbcGEBIg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2016 21:08:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u6514qRH057850
	for <linux-pci@vger.kernel.org>; Mon, 4 Jul 2016 21:08:35 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	by mx0a-001b2d01.pphosted.com with ESMTP id 23yfe90htm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 04 Jul 2016 21:08:35 -0400
Received: from localhost
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <andrew.donnellan@au1.ibm.com>;
	Tue, 5 Jul 2016 11:08:32 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
	by d23dlp01.au.ibm.com (Postfix) with ESMTP id 023D82CE805A
	for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2016 11:08:29 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u6518Sma2621740
	for <linux-pci@vger.kernel.org>; Tue, 5 Jul 2016 11:08:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u6518RHl003886
	for <linux-pci@vger.kernel.org>; Tue, 5 Jul 2016 11:08:28 +1000
Subject: Re: [PATCH 12/14] PCI/hotplug: pnv_php: export symbols and move
 struct types needed by cxl
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Ian Munsie <imunsie@au1.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
 <1467638532-9250-13-git-send-email-imunsie@au.ibm.com>
 <20160705000347.GA6557@gwshan>
Cc: Michael Neuling <mikey@neuling.org>,
	Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Huy Nguyen <huyn@mellanox.com>, linuxppc-dev@lists.ozlabs.org
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 5 Jul 2016 11:08:25 +1000
MIME-Version: 1.0
In-Reply-To: <20160705000347.GA6557@gwshan>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <df5d692d-64b1-d6a2-07bc-26774cbd8a1b@au1.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/07/16 10:03, Gavin Shan wrote:
> Andrew/Ian, it seems HOTPLUG_PCI_POWERNV_BASE isn't defined and we needn't it.

Argh, thanks for picking that up! I removed that option and all its 
occurrences in the code based on your earlier private feedback but 
forgot to drop this.

Will fix in V2.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited

