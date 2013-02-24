Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Len Brown <lenb@kernel.org>,
	Fabio Baltieri <fabio.baltieri@linaro.org>,
	Dave Jones <davej@redhat.com>, linux-pci@vger.kernel.org
Subject: [GIT PULL] ACPI and power management fixes for v3.9-rc1
Date: Sun, 24 Feb 2013 15:29:25 +0100
Message-ID: <1663657.ypAtqGpGAq@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Linus,

Please pull from the git repository at

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm+acpi-fixes-3.9-rc1

to receive ACPI and power management fixes for v3.9-rc1 with top-most commit
4383822020c54c21eb2eb939a3233b44a51e8ca0

  Merge branch 'acpi-pm' into fixes

on top of commit a0b1c42951dd06ec83cc1bc2c9788131d9fefcd8

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next

The changes below fix problems introduced by the new ACPI and PM
commits merged earlier and one older build issue.

Included are:

- Fixes for blackfin and microblaze build problems introduced by the
  removal of global pm_idle.  From Lars-Peter Clausen.

- OPP core build fix from Shawn Guo.

- Error condition check fix for the new imx6q-cpufreq driver from
  Wei Yongjun.

- Fix for an AER driver crash related to the lack of APEI
  initialization for acpi=off.  From yours truly.

- Fix for the USB breakage on Thinkpad T430 related to ACPI power
  resources and PCI wakeup reported by Dave and Fabio (you know
  about this one).

Thanks!

---------------

Lars-Peter Clausen (2):
      blackfin idle: Fix compile error
      microblaze idle: Fix compile error

Rafael J. Wysocki (2):
      ACPI / APEI: Fix crash in apei_hest_parse() for acpi=off
      ACPI / PM: Take unusual configurations of power resources into account

Shawn Guo (1):
      PM / OPP: fix condition for empty of_init_opp_table()

Wei Yongjun (1):
      imx6q-cpufreq: fix return value check in imx6q_cpufreq_probe()

---------------

 arch/blackfin/kernel/process.c   |    4 +-
 arch/microblaze/kernel/process.c |    5 +--
 drivers/acpi/apei/hest.c         |    5 +--
 drivers/acpi/internal.h          |    2 +-
 drivers/acpi/power.c             |  112 +++++++++++++++++++++++++++++++++++-----------
 drivers/acpi/scan.c              |    9 +++-
 drivers/cpufreq/imx6q-cpufreq.c  |    2 +-
 include/linux/opp.h              |   18 ++++----
 8 files changed, 107 insertions(+), 50 deletions(-)

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
