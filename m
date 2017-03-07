Return-Path: <SRS0=bUAO=2Q=networkplumber.org=stephen@kernel.org>
Return-Path: <SRS0=bUAO=2Q=networkplumber.org=stephen@kernel.org>
Date: Tue, 7 Mar 2017 11:58:08 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Elena Reshetova <elena.reshetova@intel.com>, Stephen Hemminger
 <sthemmin@microsoft.com>, Kees Cook <keescook@chromium.org>,
 linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, Hans
 Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>
Subject: Re: [PATCH 17/29] drivers, pci: convert hv_pci_dev.refs from
 atomic_t to refcount_t
Message-ID: <20170307115808.16f5235e@xeon-e3>
In-Reply-To: <20170306213829.GB5305@bhelgaas-glaptop.roam.corp.google.com>
References: <1488810076-3754-1-git-send-email-elena.reshetova@intel.com>
	<1488810076-3754-18-git-send-email-elena.reshetova@intel.com>
	<20170306213829.GB5305@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

On Mon, 6 Mar 2017 15:38:29 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Hyper-V folks, -cc others]
> 
> On Mon, Mar 06, 2017 at 04:21:04PM +0200, Elena Reshetova wrote:
> > refcount_t type and corresponding API should be
> > used instead of atomic_t when the variable is used as
> > a reference counter. This allows to avoid accidental
> > refcounter overflows that might lead to use-after-free
> > situations.
> > 
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: David Windsor <dwindsor@gmail.com>


Reviewed-by: Stephen Hemminger <sthemmin@microsoft.com>
