Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from erley.org ([97.107.129.9]:34704 "EHLO remote.erley.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754415Ab2JTAhp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 19 Oct 2012 20:37:45 -0400
Received: from [IPv6:2001:4978:142:0:223:15ff:fed1:55bc] (unknown [IPv6:2001:4978:142:0:223:15ff:fed1:55bc])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by remote.erley.org (Postfix) with ESMTPSA id 4A5D92862E
	for <linux-pci@vger.kernel.org>; Sat, 20 Oct 2012 00:31:15 +0000 (UTC)
Message-ID: <5081F0D2.50509@erley.org>
Date: Fri, 19 Oct 2012 20:31:14 -0400
From: Pat Erley <pat-lkml@erley.org>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: Ricoh Multifunction Device DMAR Bug
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I've been hitting the bug talked about in this thread:

https://bugzilla.redhat.com/show_bug.cgi?id=605888

and using the patch in Comment 7 as a work around.  In reading on, I saw 
that redhat released a kernel (kernel-2.6.35.6-45.fc14) that contains a 
patch like this:

http://lists.fedoraproject.org/pipermail/scm-commits/2010-October/510785.html

Is there any reason to omit this from mainline?  The patch that redhat 
is using seems like a 'better' fix than the fixup I'm using from Comment 
7, but does that completely disable DMAR when this device is present? 
That seems like an overkill approach, when there is the hack from the 
thread from redhat's bugzilla.  Is there some other impact from the 
patch I'm using?  Everything works fine on my system with it.

Anyways, the point to all of this was, I really don't like having to 
carry patches and apply them with each update.  I'd love to see some 
fixup get into mainline, especially if it can be minimal impact on 
functionality, like the first thread linked here.  Is there anything 
else I can provide to help facilitate this?

Pat Erley
