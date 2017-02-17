Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v2 04/22] Documentation: PCI: Guide to use pci endpoint
 configfs
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, Joao Pinto
 <Joao.Pinto@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-5-git-send-email-kishon@ti.com>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <ac16c03a-e415-327c-27b3-bcc700a6f953@synopsys.com>
Date: Fri, 17 Feb 2017 13:05:32 +0000
MIME-Version: 1.0
In-Reply-To: <1487325042-28227-5-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="windows-1252"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

=C0s 9:50 AM de 2/17/2017, Kishon Vijay Abraham I escreveu:
> Add Documentation to help users use pci endpoint to configure
> pci endpoint function and to bind the endpoint function
> with endpoint controller.
> =

> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/PCI/00-INDEX                      |    2 +
>  Documentation/PCI/endpoint/pci-endpoint-cfs.txt |   84 +++++++++++++++++=
++++++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> =

> diff --git a/Documentation/PCI/00-INDEX b/Documentation/PCI/00-INDEX
> index ba950b2..f84a23c 100644
> --- a/Documentation/PCI/00-INDEX
> +++ b/Documentation/PCI/00-INDEX
> @@ -14,3 +14,5 @@ pcieaer-howto.txt
>  	- the PCI Express Advanced Error Reporting Driver Guide HOWTO
>  endpoint/pci-endpoint.txt
>  	- guide to add endpoint controller driver and endpoint function driver.
> +endpoint/pci-endpoint-cfs.txt
> +	- guide to use configfs to configure the pci endpoint function.
> diff --git a/Documentation/PCI/endpoint/pci-endpoint-cfs.txt b/Documentat=
ion/PCI/endpoint/pci-endpoint-cfs.txt
> new file mode 100644
> index 0000000..d9f8734
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-endpoint-cfs.txt
> @@ -0,0 +1,84 @@
> +                   CONFIGURING PCI ENDPOINT USING CONFIGFS
> +                    Kishon Vijay Abraham I <kishon@ti.com>
> +
> +The PCI Endpoint Core exposes configfs entry (pci_ep) in order to config=
ure the
> +PCI endpoint function and in order to bind the endpoint function
> +with the endpoint controller. (For introducing other mechanisms to
> +configure the PCI Endpoint Function refer [1]).
> +
> +*) Mounting configfs
> +
> +The PCI Endpoint Core layer creates pci_ep directory in the mounted conf=
igfs
> +directory. configfs can be mounted using the following command.
> +
> +	mount -t configfs none /sys/kernel/config
> +
> +*) Directory Structure
> +
> +The pci_ep configfs directory structure has been created to reflect the
> +natural tree like structure of PCI devices. So every directory created
> +inside pci_ep represents a EPC device and every directory created inside
> +epf directory represents EPF device.
> +
> +/sys/kernel/config/pci_ep/
> +			 | <dir>/ --------------------------------------> [2]
> +				| epc
> +				| epf/
> +				     | <dir>/ --------------------------> [3]
> +					    | vendorid
> +					    | deviceid
> +					    | revid
> +					    | progif_code
> +					    | subclass_code
> +					    | baseclass_code
> +					    | cache_line_size
> +					    | subsys_vendor_id
> +					    | subsys_id
> +					    | interrupt_pin
> +					    | function
> +
> +*) Creating configfs entry for EPC
> +
> +Any directory created inside *pci_ep* represents an EPC device. In the a=
bove
> +directory structure [2] represents an EPC device. It consists of
> +
> +	*) epc: Use it to associate the configfs entry to an actual EPC device.
> +		The list of valid entries for this field can be obtained from
> +			ls /sys/class/pci_epc/
> +
> +	*) epf: Directory that contains all the endpoint functions. The name
> +		of the created directory determines the driver this particular
> +		epf device will be bound to. The name can be obtained either
> +		from the function binding documentation [4] or
> +			ls /sys/bus/pci-epf/drivers
> +
> +		If more than one endpoint function device has to be bound to
> +		the same driver, then the directory should be created using
> +		the following notation
> +			mkdir <name>.<num>
> +
> +*) Creating configfs entry for EPF
> +
> +Any directory created inside *epf* directory represents an EPF device. I=
n the
> +above directory structure, [3] represents an EPF device. It consists of =
the
> +following entries that can be used to configure the standard configurati=
on
> +header of the endpoint function. (These entries are created by the
> +framework when any new directory is created inside epf directory.)
> +
> +        | vendorid
> +        | deviceid
> +        | revid
> +        | progif_code
> +        | subclass_code
> +        | baseclass_code
> +        | cache_line_size
> +        | subsys_vendor_id
> +        | subsys_id
> +        | interrupt_pin
> +
> +The following entry identifies the function driver that is bound to the
> +function device
> +	| function
> +
> +[1] -> Documentation/PCI/endpoint/pci-endpoint.txt
> +[4] -> Documentation/PCI/endpoint/function/binding/
> =


Good content.

Acked-By: Joao Pinto <jpinto@synopsys.com>



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
