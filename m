Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4061 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab3FZHVx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 26 Jun 2013 03:21:53 -0400
Date: Wed, 26 Jun 2013 10:25:36 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Yinghai Lu <yinghai@kernel.org>, john.ronciak@intel.com,
	miles.j.penner@intel.com, bruce.w.allan@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 0/6] Thunderbolt workarounds take 2
Message-ID: <20130626072536.GN9294@intel.com>
References: <1372177330-28013-1-git-send-email-mika.westerberg@linux.intel.com>
 <12066786.EK0Z2aX1JA@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <12066786.EK0Z2aX1JA@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 26, 2013 at 01:24:25AM +0200, Rafael J. Wysocki wrote:
> Would you please CC things touching ACPIPHP to linux-acpi?

Sorry about that -- It wasn't listed in the output of get_maintainers.pl so
it kind of was forgotten.

Do you want me to resend this series with linux-acpi@ included?
