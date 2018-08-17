Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
Return-Path: <SRS0=a9CN=LA=kernel.crashing.org=benh@kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] pci: Rework is_added race fix and address bridge enable races
Date: Fri, 17 Aug 2018 14:48:56 +1000
Message-Id: <20180817044902.31420-1-benh@kernel.crashing.org>
List-ID: <linux-pci.vger.kernel.org>

This is really two series but since they conflict a bit separately
here they are in one:

First we undo the mess of those atomic priv_flags. The atomicity
doesn't provide any security since there's no locking against
the other state pertaining to those flags, it only protects the
flags themselves.

The is_added mess is fixed much more simply by moving the assignment
of the flag to before we start the driver. This is in line with the
rest of the PCI code: until bound to the device model, we are essentially
assuming a single threaded environment. is_added is a flag that is
logically owned by that part of the PCI code, and thus should be set
and cleared within that "safer" environment.

This removes the horrid relative includes in the powerpc code as well.

The second part aims at fixing the enable/disable/set_master races,
and does so by providing a framework for future device state locking
issues.

It introduces a pci_dev->state_mutex which is used at a lower level
than the device_lock (the device lock isn't suitable, as explained
in the cset comments) and uses it to protect enablement and set_master.
