Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 27 Apr 2017 10:44:27 +0200
From: Joerg Roedel <jroedel@suse.de>
To: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Cc: Sricharan R <sricharan@codeaurora.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        netdev@vger.kernel.org
Subject: Re: [REGRESSION next-20170426] Commit 09515ef5ddad ("of/acpi:
 Configure dma operations at probe time for platform/amba/pci bus devices")
 causes oops in mvneta
Message-ID: <20170427084427.GV5077@suse.de>
References: <20170426181508.687b52af@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170426181508.687b52af@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Sricharan,

On Wed, Apr 26, 2017 at 06:15:08PM +0200, Ralph Sennhauser wrote:
> Commit 09515ef5ddad ("of/acpi: Configure dma operations at probe time
> for platform/amba/pci bus devices") causes a kernel panic as in the log
> below on an armada-385. Reverting the commit fixes the issue.

Any insight here? I tend to revert the patch in my tree, or is there a
quick and easy fix?



	Joerg

