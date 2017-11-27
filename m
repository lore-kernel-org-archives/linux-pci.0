Return-Path: <SRS0=HXDS=CZ=daenzer.net=michel@kernel.org>
Return-Path: <SRS0=HXDS=CZ=daenzer.net=michel@kernel.org>
Subject: Re: [PATCH] PCI: use dev_info rather than dev_err for rom validation
To: Alex Deucher <alexdeucher@gmail.com>, helgaas@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 Alex Deucher <alexander.deucher@amd.com>
References: <20171127172110.16699-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <02e87fb8-8b77-281b-eac7-d592802da054@daenzer.net>
Date: Mon, 27 Nov 2017 19:00:43 +0100
MIME-Version: 1.0
In-Reply-To: <20171127172110.16699-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 2017-11-27 06:21 PM, Alex Deucher wrote:
> On AMD GPUs, we use several mechanisms to fetch the vbios
> rom depending on the platform.  We try to read the rom
> back via the rom BAR and fall back to other methods in
> some cases.  This leads to spurious error messages
> from the pci rom code which are harmless in our case.
> This leads to bugs being files, etc.  Change these to
> dev_info rather than dev_err to avoid that.

Does dev_info still print the message by default though? If so, I wonder
if this will change anything in practice...


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
