Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthew Garrett <mjg@redhat.com>
To: matt.fleming@intel.com
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: efi, x86, pci: Improve graphics support on some Apple hardware 
Date: Thu, 26 Jul 2012 18:02:45 -0400
Message-Id: <1343340169-7772-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Some Apple machines only provide their video ROM via an EFI-specific mechanism
and don't permit it to be retrieved from the BAR. Add infrastructure to stash
it and provide access to drivers.

