Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 29 Oct 2013 07:34:14 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Veaceslav Falico <vfalico@redhat.com>
Cc: linux-pci@vger.kernel.org, torvalds@linux-foundation.org,
	tglx@linutronix.de, yinghai@kernel.org, Knut_Petersen@t-online.de,
	mingo@kernel.org, paulmck@linux.vnet.ibm.com, fweisbec@gmail.com,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/3] pci: remove redundant pci_dev_get/put() on
 kobject (un)register
Message-ID: <20131029113414.GC24477@neilslaptop.think-freely.org>
References: <1383042632-7102-1-git-send-email-vfalico@redhat.com>
 <1383042632-7102-3-git-send-email-vfalico@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383042632-7102-3-git-send-email-vfalico@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 29, 2013 at 11:30:31AM +0100, Veaceslav Falico wrote:
> Currently we're pci_dev_get/put()-ing pci device on every kobject
> creation/removal. It's useless per se - the kobject is part of the device
> itself, so it should be removed when there are no users of the pdev, and is
> not a user of it.
> 
> CC: Bjorn Helgaas <bhelgaas@google.com>
> CC: Neil Horman <nhorman@tuxdriver.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: linux-pci@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> Signed-off-by: Veaceslav Falico <vfalico@redhat.com>
Acked-by: Neil Horman <nhorman@tuxdriver.com>

> 
