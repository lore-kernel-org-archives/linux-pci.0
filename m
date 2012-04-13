Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:59348 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932961Ab2DMJpD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 13 Apr 2012 05:45:03 -0400
Received: from /spool/local
	by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <linuxram@us.ibm.com>;
	Fri, 13 Apr 2012 05:45:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 55D2338C8054
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 05:44:59 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q3D9ix5l289044
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 05:44:59 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q3D9iwkQ023264
	for <linux-pci@vger.kernel.org>; Fri, 13 Apr 2012 06:44:59 -0300
Date: Fri, 13 Apr 2012 17:44:50 +0800
From: Ram Pai <linuxram@us.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linuxram@us.ibm.com, shangw@linux.vnet.ibm.com
Subject: Re: [PATCH] Optimize the resource overlap check
Message-ID: <20120413094450.GE20495@ram-ThinkPad-T61>
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1334284128-24925-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334284128-24925-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2012 at 10:28:48AM +0800, Wei Yang wrote:
> In coalesce_windows() it tries to check whether the res1 and res2 overlap.
> This function do four comparisons, which could be done with one
> comparisons.
> 
> Also make the resource_check_overlap() a common function for others.
> 
> Signed-Off-By: Wei Yang <weiyang@linux.vnet.ibm.com>

Signed-Off-By: Ram Pai <linuxram@us.ibm.com>


