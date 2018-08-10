Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbeHJEm4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Aug 2018 00:42:56 -0400
Subject: Re: [PATCH 1/2] PCI/ACPI: correct error message for ASPM disabling
To: Joe Perches <joe@perches.com>, linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1533840383-7841-1-git-send-email-okaya@kernel.org>
 <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <2a8b5c60-45ba-1fc4-d261-fcfbd7f16910@kernel.org>
Date: Thu, 9 Aug 2018 22:15:09 -0400
MIME-Version: 1.0
In-Reply-To: <307063ff7bbdcc0c3896f027b09245e542764f48.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/9/2018 8:27 PM, Joe Perches wrote:
> I think this would read better not using a temporary and
> using a ternary instead.

Makes sense.
