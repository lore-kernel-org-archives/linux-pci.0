Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 4 May 2017 15:14:46 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-input@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1] ACPI: Switch to use generic UUID API
Message-ID: <20170504121446.GA26032@kuha.fi.intel.com>
References: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170504092151.88646-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 04, 2017 at 12:21:51PM +0300, Andy Shevchenko wrote:
> acpi_evaluate_dsm() and friends take a pointer to a raw buffer of 16
> bytes. Instead we convert them to use uuid_le type. At the same time we
> convert current users.
> 
> acpi_str_to_uuid() becomes useless after the conversion and it's safe to
> get rid of it.
> 
> The conversion fixes a potential bug in int340x_thermal as well since
> we have to use memcmp() on binary data.
> 
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Yisen Zhuang <yisen.zhuang@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Mathias Nyman <mathias.nyman@intel.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

OK by me, FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>


Thanks,

-- 
heikki
