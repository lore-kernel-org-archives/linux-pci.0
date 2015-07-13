Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 13 Jul 2015 09:35:18 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Jordan Hargrave <jharg93@gmail.com>
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Jordan_Hargrave@dell.com
Subject: Re: [PATCH] Add support for reading SMBIOS Slot number for PCI
 devices
Message-ID: <20150713093518.7e869d07@endymion.delvare>
In-Reply-To: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
References: <1436565766-21820-1-git-send-email-jordan_hargrave@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jordan,

On Fri, 10 Jul 2015 17:02:46 -0500, Jordan Hargrave wrote:
> From: Jordan Hargrave <Jordan_Hargrave@dell.com>
> 
> There currently isn't an easy way to determine which PCI devices belong to
> system slots.  This patch adds support to read SMBIOS Type 9 (System Slots).

I'm wondering, can't you use dmidecode or libsmbios to retrieve the
same information?

-- 
Jean Delvare
SUSE L3 Support
