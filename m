Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To: Bjorn Helgaas <helgaas@kernel.org>, Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Keith Busch <keith.busch@intel.com>,
 Vidya Sagar <vidyas@nvidia.com>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Sinan Kaya
 <okaya@codeaurora.org>, Frederick Lawler <fred@fredlawl.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 mayurkumar.patel@intel.com, rajatxjain@gmail.com,
 Richard Hughes <rhughes@redhat.com>, Carlos Garnacho <cgarnach@redhat.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pali Rohar <pali.rohar@gmail.com>,
 Takashi Iwai <tiwai@suse.de>, Andy Whitcroft <apw@canonical.com>,
 Colin Ian King <colin.king@canonical.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
Date: Sat, 28 Jul 2018 17:16:13 -0700
MIME-Version: 1.0
In-Reply-To: <20180727202619.GD173328@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 7/27/2018 1:26 PM, Bjorn Helgaas wrote:
> - A link can lead to a multi-function device, and the spec allows
>      those functions to have different ASPM settings (see PCIe r4.0,
>      sec 5.4.1).  With the sysfs files at the upstream end of the link,
>      we have no way to configure those functions individually.

Even though we can set them individually, there is only one PCIe link
for single function as well as multi-function devices.

It would be a user mistake to allow individual PCIe functions with
different ASPM policies. (maybe, we should enforce it if we are not
doing it already).
