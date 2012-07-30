Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5016CC75.3050806@redhat.com>
Date: Mon, 30 Jul 2012 14:03:33 -0400
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Huang Ying <ying.huang@intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Mork <bjorn@mork.no>
Subject: Re: [RFC] PCI/PM: Add ABI document for sysfs file d3cold_allowed
References: <1343376454-28520-1-git-send-email-ying.huang@intel.com>
In-Reply-To: <1343376454-28520-1-git-send-email-ying.huang@intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 07/27/2012 04:07 AM, Huang Ying wrote:
> This patch adds ABI document for the following sysfs file:
>
> /sys/bus/pci/devices/.../d3cold_allowed
>
> Signed-off-by: Huang Ying<ying.huang@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-pci |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -210,3 +210,15 @@ Users:
>   		firmware assigned instance number of the PCI
>   		device that can help in understanding the firmware
>   		intended order of the PCI device.
> +
> +What:		/sys/bus/pci/devices/.../d3cold_allowed
> +Date:		July 2012
> +Contact:	Huang Ying<ying.huang@intel.com>
> +Description:
> +		d3cold_allowed is bit to control whether the corresponding PCI
> +		device can be put into D3Cold state.  If it is cleared, the
> +		device will never be put into D3Cold state.  If it is set, the
> +		device may be put into D3Cold state if other requirement are
did you mean 'requirements' here? -------------------------------^
or is there only 1 other requirement?

> +		satisfied too.  Reading this attribute will show the current
> +		value of d3cold_allowed bit.  Writting this attribute will set
spell checker says 'Writing' --------------------^

> +		the value of d3cold_allowed bit.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

