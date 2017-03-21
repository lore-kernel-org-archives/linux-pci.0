Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758390AbdCUXtJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2017 19:49:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2LNmjIa111625
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2017 19:49:07 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vm24jg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2017 19:49:07 -0400
Received: from localhost
        by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
        Wed, 22 Mar 2017 09:49:04 +1000
Date: Wed, 22 Mar 2017 10:48:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Eli Cohen <eli@mellanox.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Gavin Shan <gwshan@linux.vnet.ibm.com>,
        Bodong Wang <bodong@mellanox.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH] pci/sriov: Add an option to probe VFs or not before
 enabling SR-IOV
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1490022874-54718-1-git-send-email-bodong@mellanox.com>
 <20170320230706.GA12252@gwshan>
 <7bfcfdcd-e0a8-f1e9-f112-fa35fdb845d7@mellanox.com>
 <20170320225708.6868676a@t450s.home>
 <20170321054305.GA12230@gwshan>
 <20170321000158.444991a3@t450s.home>
 <20170321092518.GA19657@gwshan>
 <20170321082329.4f408a9e@t450s.home>
 <VI1PR0501MB2798FFB6E0337AB860B5D2A8C53D0@VI1PR0501MB2798.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR0501MB2798FFB6E0337AB860B5D2A8C53D0@VI1PR0501MB2798.eurprd05.prod.outlook.com>
Message-Id: <20170321234805.GB3972@gwshan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 21, 2017 at 02:34:46PM +0000, Eli Cohen wrote:
>> If we want to talk about the ABI, I would suggest drawing from existing ABIs.  We already have
>> drivers_autoprobe as part of the standard sysfs ABI, so if we want a binary switch, then 
>>sriov_drivers_autoprobe might be a logical choice.  If you're concerned about this mythical overhead of > binding to one driver then another, then why not draw from the driver_override interface to allow the 
>> user to specify the driver to bind to, perhaps sriov_driver_override.  Then if the user wants to bind all 
>> the devices to vfio-pci, they can do so easily.  I still fail to see that probing some fixed number of the VFs 
>> and leaving the rest unprobed has any practical value and I imagine bugs coming in because users are 
>> confused why some of their VFs behave differently than others.  Thanks,
>
>I agree with Alex - the interface should better be binary - either probe VFs or not. The rest can be done with binding/unbinding VFs as necessary. The main goal is to refrain from automatically initializing virtual functions at the hypervisor if they were initially instantiated to assign then to guests.
>

It's fairly reasonable. Thanks for confirm. I'll review v2.

Thanks,
Gavin
