Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Keith Busch <keith.busch@intel.com>, Vidya Sagar <vidyas@nvidia.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Kees Cook
 <keescook@chromium.org>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
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
 <5a102163-73bc-c596-8266-186e222e7ceb@kernel.org>
 <20180730141428.GK173328@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <2fbc0d1b-0d14-6bab-74c5-a9dd2ae417bb@kernel.org>
Date: Mon, 30 Jul 2018 09:08:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180730141428.GK173328@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 7/30/2018 7:14 AM, Bjorn Helgaas wrote:
> However, the end of sec 5.4.1 does make it clear that the functions
> need not have the same ASPM configuration, and it gives rules for how
> those different settings should affect the shared link.  Since it
> mentions different ASPM Control fields for the different functions, I
> assume the policy combining those per-function settings into the
> single link behavior must be implemented in the hardware.

Very interesting. This is news for me.
