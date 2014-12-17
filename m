Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095AbaLQQSo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Dec 2014 11:18:44 -0500
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id sBHGIhpL017234
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2014 10:18:43 -0600
Received: from DLEE71.ent.ti.com (dlee71.ent.ti.com [157.170.170.114])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id sBHGIhI5009385
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2014 10:18:43 -0600
Received: from [158.218.104.233] (ileax41-snat.itg.ti.com [10.172.224.153])	by
 dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id sBHGIhxS019527	for
 <linux-pci@vger.kernel.org>; Wed, 17 Dec 2014 10:18:43 -0600
Message-ID: <5491ACE6.4070108@ti.com>
Date: Wed, 17 Dec 2014 11:18:46 -0500
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: How to fix CHECK warning: testing a 'safe expression' ?
References: <54907884.2040502@ti.com>
In-Reply-To: <54907884.2040502@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I am trying to address CHECK warnings in my driver and wondering how to 
resolve 'warning: testing a 'safe expression' which appears when using
IS_ERR_OR_NULL(foo)

where foo is defined as

struct foo_type *foo;

The foo get assigned only NULL or ERR_PTR(error code). So I believe the
usage is correct. But then how do I make the CHECK happy of its usage?

I have tried a grep to check on the current usage of IS_ERR_OR_NULL() 
and found 276 of them causes this warning in the v3.18 version of the 
kernel that I am using

$ grep -r "warning: testing a 'safe expression" * | wc -l
276

Can someone help me undestand what this means and how to fix the same?

I run folling for CHECK

make C=2 CF="-D__CHECK_ENDIAN__" CHECK=sparse

Thanks in advance for your suggestions.
-- 
Murali Karicheri
Linux Kernel, Texas Instruments
--
To unsubscribe from this list: send the line "unsubscribe netdev" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
