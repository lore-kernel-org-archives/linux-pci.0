Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Apr 2015 09:49:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <20150402094608-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <20150402094424.0de6c990@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402094424.0de6c990@endymion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 02, 2015 at 09:44:24AM +0200, Jean Delvare wrote:
> It could be that a small subset of pci_ids.h could be shared with
> user-space. I'm thinking of classes, because that list is short and
> stable, so we can give some stability guarantees. But I don't know if
> the user-space projects you quoted actually use that, so even that may
> not be worth it.
> 
> -- 
> Jean Delvare
> SUSE L3 Support

Yes, class IDs is the part that's duplicated across multiple
userspace projects.

So exporting it is exactly what v2 of the patch did:
mid.gmane.org/1427714755-16873-1-git-send-email-mst@redhat.com

Please review that.

-- 
MST
