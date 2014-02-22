Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 22 Feb 2014 20:56:04 +0100
From: Alexander Gordeev <agordeev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jon Mason <jon.mason@intel.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ntb: Use pci_enable_msix_range() instead of
 pci_enable_msix()
Message-ID: <20140222195603.GB14528@dhcp-26-207.brq.redhat.com>
References: <cover.1392996332.git.agordeev@redhat.com>
 <20140221160937.GA913@dhcp-26-207.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140221160937.GA913@dhcp-26-207.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 21, 2014 at 05:09:37PM +0100, Alexander Gordeev wrote:
> Ouch, I was too fast. Patch #3 introduces warning "unused variable ‘msix’"
> I can re-post if you want, but the rest is still is up to review ;)

Resent.

-- 
Regards,
Alexander Gordeev
agordeev@redhat.com
