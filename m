Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
References: <1485793552-12614-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170130211236.GW20550@bhelgaas-glaptop.roam.corp.google.com>
 <20170131102830.GA13854@localhost.localdomain>
 <20170131142525.GA9942@bhelgaas-glaptop.roam.corp.google.com>
 <20170131145720.GA14231@localhost.localdomain>
 <20170131203109.GA14127@bhelgaas-glaptop.roam.corp.google.com>
 <20170201125325.GA15805@localhost.localdomain>
 <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <376ae1df-da85-e576-75d6-3ae2ab0f1b41@jonmasters.org>
Date: Wed, 15 Mar 2017 07:14:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: David.Daney@cavium.com, tn@semihalf.com, linux-kernel@vger.kernel.org,
 stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com, linux-pci@vger.kernel.org,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Vadim,

Following up to this old thread...

On 02/01/2017 10:18 AM, Bjorn Helgaas wrote:
> On Wed, Feb 01, 2017 at 04:53:25AM -0800, Vadim Lomovtsev wrote:

>>>> Because there is no such ACPI ID as "THRX0002" registered
>>>> (http://www.uefi.org/acpi_id_list).

There is still no "THRX" prefix registered with UEFI as of this morning.

>>> To be pedantically correct, I think you want "THRX" registered.  Then
>>> you can manage the "0002" part internally without registering each
>>> individual device.

The upstream Linux kernel contains a quirk matching entry that looks for
"THRX". Therefore, you have already agreed (as of at least January) that
this is the prefix that you will use in any firmware updates to support
the latest upstream Linux kernel. Please register this prefix promptly.

>> Not sure if it would be registered that way, because (AFAIK)
>> it expected to be string constructed from Vendor ID (not the Product ID) plus
>> four hex digit manged internaly. So we suggest to change it to 177DXXXX
>> which corresponds to Cavium PCI ID https://pci-ids.ucw.cz/pci.ids.
>> It's also possible to use the 3-digit PNP ID, "CAV", to construct these
>> _HID/_CID/_SUB values (http://www.uefi.org/pnp_id_list).
> 
> My point was that you only need to register the prefix ("CAV" or
> "THRX") of the PNP or ACPI ID.  Then you manage the suffixes
> internally.  You as long as you register "CAV" or "THRX", you can
> assign and use "THRX0002" yourself without registering that
> specifically.
> 
>> So the FW will be updated accordingly.

Indeed.

The version Bjorn merged looks for "THRX". This is the version that you will
use, and you will promptly register that prefix with UEFI and provide fixes
for existing firmware to correctly use the solution that is upstream.

Thanks,

Jon.


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
