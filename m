Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbaJWSVp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 23 Oct 2014 14:21:45 -0400
Message-ID: <54494735.20505@redhat.com>
Date: Thu, 23 Oct 2014 14:21:41 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Prarit Bhargava <prarit@redhat.com>
CC: rhkernel-list@redhat.com, Myron Stowe <mstowe@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alexander Ducyk <alexander.h.duyck@redhat.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH V2] pci, add sysfs numa_node write function
References: <1414088454-24522-1-git-send-email-prarit@redhat.com>
In-Reply-To: <1414088454-24522-1-git-send-email-prarit@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 10/23/2014 02:20 PM, Prarit Bhargava wrote:
> Some new drivers, such as the Intel QAT driver, drivers/crypto/qat,
> require that a specific node be assigned to the device in order to
> achieve maximum performance for the device, and will fail to load if the
> device has NUMA_NO_NODE.  Users can in some cases, with additional
> information provided by vendor support, determine what the correct numa
> node is supposed to be.  In the cases a quick hack of the driver results
> in a function QAT device.
> 

Sorry everyone -- sent this to the wrong list.

P.
