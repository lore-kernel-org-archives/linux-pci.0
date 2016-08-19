Return-Path: <imunsie@au1.ibm.com>
Return-Path: <imunsie@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
From: Ian Munsie <imunsie@au1.ibm.com>
To: "andrew.donnellan" <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clombard <clombard@linux.vnet.ibm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        gwshan <gwshan@linux.vnet.ibm.com>,
        fbarrat <fbarrat@linux.vnet.ibm.com>,
        mauricfo <mauricfo@linux.vnet.ibm.com>, helgaas <helgaas@kernel.org>,
        Philippe Bergheaud <felix@linux.vnet.ibm.com>,
        ukrishn <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: use pcibios_free_controller_deferred() when removing vPHBs
In-reply-to: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1471505714-30049-1-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Fri, 19 Aug 2016 12:59:17 +1000
Message-Id: <1471575548-sup-5761@x230.ozlabs.ibm.com>
List-ID: <linux-pci.vger.kernel.org>

Acked-by: Ian Munsie <imunsie@au1.ibm.com>
