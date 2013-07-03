Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 3 Jul 2013 21:41:23 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>, john.ronciak@intel.com,
	miles.j.penner@intel.com, bruce.w.allan@intel.com,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/8] Thunderbolt workarounds
Message-ID: <20130703184123.GC4898@intel.com>
References: <1372860295-8306-1-git-send-email-mika.westerberg@linux.intel.com>
 <20130703182900.GA29079@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130703182900.GA29079@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 03, 2013 at 07:29:00PM +0100, Matthew Garrett wrote:
> Are there any plans to provide native support for the Thunderbolt 
> controller, rather than relying on system management mode?

I believe there are some to implement a native Thunderbolt controller
driver but I don't know the details. 

Bruce Allan and Miles Penner (who are CC'd here) might have a better answer
for you.
