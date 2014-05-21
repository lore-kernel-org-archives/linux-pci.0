Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:49088 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbaEUFJG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 May 2014 01:09:06 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 21 May 2014 15:09:04 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7A0362BB0047
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 15:09:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s4L58kdI11600246
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 15:08:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s4L590hJ003106
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2014 15:09:01 +1000
Date: Wed, 21 May 2014 15:09:00 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Greg Thelen <gthelen@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] PCI: Fix return value from
 pci_user_{read,write}_config_*()
Message-ID: <20140521050900.GA9553@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1399942683-23898-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo5brfq1uPqPs3es_-S=awxuAX_f8ruSvL8Mnr=Vv1SAPw@mail.gmail.com>
 <xr93tx8ln4im.fsf@gthelen.mtv.corp.google.com>
 <20140520110630.GA13175@shangw>
 <xr93r43omoqm.fsf@gthelen.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <xr93r43omoqm.fsf@gthelen.mtv.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 20, 2014 at 08:52:33AM -0700, Greg Thelen wrote:

.../...

>>
>> Perhaps, I just need remove the "default" case. I think the PCI config accessors
>> of individual platforms should return one of the following values, which are
>> defined in include/linux/pci.h. The unrecognized return value should be translated
>> to "-ERANGE" directly.
>
>Sounds good to me.
>

Thanks, Greg. I'm going to change it accordingly and send "v2" out.

Thanks,
Gavin

