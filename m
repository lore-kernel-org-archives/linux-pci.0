Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 10/10] tools: PCI: Add MSI-X support
Date: Tue, 24 Apr 2018 09:57:45 +0000
Message-ID: <SN6PR07MB45126298F09735193B0F0F00D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <9865822fb89ea84cb55fe93e151295afcd5c96b3.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <9865822fb89ea84cb55fe93e151295afcd5c96b3.1523379766.git.gustavo.pimentel@synopsys.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gustavo,

On 10 April 2018 18:15, Gustavo Pimentel wrote:
> Adds MSI-X support to the pcitest tool and modified the pcitest.sh script=
 to
> accomodate this new type of interruption test.
>=20
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  include/uapi/linux/pcitest.h |  1 +
>  tools/pci/pcitest.c          | 18 +++++++++++++++++-
>  tools/pci/pcitest.sh         | 25 +++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
I found some possible problems when testing with the Cadence EP driver.  Th=
e problem
is that pcitest uses the BARs for tests, but we also use one for the MSI-X =
tables

In Cadence core the MSI-X table is in BAR0 by default, but this is configur=
ed to a size
of 0x80 in the test driver, since it is used as the test_reg_bar.  So, I ch=
anged the=20
configuration to use BAR4 instead, which is configured to a size of 131072=
=20
in pci-efp-test.c, and this gives me enough space.

However, if I run the BAR tests in pcitest before running the MSI-X tests, =
the
MSI-X tests fail, since the BAR content is overwritten.  It's not a problem=
 with the=20
scenario in pcitest.sh, but it would be if the module wasn't re-loaded.

So, wondering if we need to come up with some mechanism to specify that a s=
pecific
BAR will be used for MSI-X, and that its size and content shouldn't be modi=
fied by
pcitest?

Regards,
Alan
