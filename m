Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33895 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094AbbDNWyS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2015 18:54:18 -0400
Received: by iedfl3 with SMTP id fl3so31227184ied.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2015 15:54:17 -0700 (PDT)
Received: from google.com ([69.71.1.1])
        by mx.google.com with ESMTPSA id i198sm1283841ioe.15.2015.04.14.15.54.16
        for <linux-pci@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Apr 2015 15:54:17 -0700 (PDT)
Date: Tue, 14 Apr 2015 17:54:15 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Subject: Open PCI issues
Message-ID: <20150414225414.GC19151@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The backlog of PCI regressions and issues seems to be growing.
Feel free to participate in analyzing and fixing them.

Here's a query for open regressions:

  https://bugzilla.kernel.org/buglist.cgi?bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&bug_status=NEEDINFO&cf_regression=Yes&columnlist=assigned_to%2Cbug_status%2Ccf_kernel_version%2Cshort_short_desc&component=PCI&order=bug_id%20DESC

Here's one for open issues in general:

  https://bugzilla.kernel.org/buglist.cgi?bug_status=NEW&bug_status=ASSIGNED&bug_status=REOPENED&bug_status=NEEDINFO&columnlist=assigned_to%2Cbug_status%2Ccf_kernel_version%2Cshort_short_desc&component=PCI&order=bug_id%20DESC
